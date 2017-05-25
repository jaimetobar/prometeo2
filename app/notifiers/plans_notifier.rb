class PlansNotifier

  def self.notify(body)
    uri = URI(ENV["notification_webhook"])
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
      req = Net::HTTP::Post.new(uri)
      req['Content-Type'] = 'application/json'

      req.body = body.to_json

      http.request(req)
    end
  end

  def self.notify_create(user)
    self.notify({
      action: :create,
      data: self.build_data(user)
    })
  end

  def self.notify_update(user)
    self.notify({
      action: :update,
      data: self.build_data(user)
    })
  end

  private

    def self.build_data(user)
      {
        email: user.email,
        name: user.name,
        partner_name: user.partner_name,
        country: user.country,
        created_at: user.created_at,
        notification_timestamp: DateTime.now,
        subscriptions: user.subscriptions.includes(:accreditation, course: [:course_sessions]).map do |s|
          {
            course: s.course.try(:name),
            accreditation: s.accreditation.try(:name),
            finished: s.finished,
            session_type: s.course.try(:session_type),
            next_date: s.course.try(:next_session),
            created_at: s.created_at,
          }
        end
      }
    end
end
