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
    user.subscriptions.includes(:accreditation, course: [:course_sessions]).each do |s|
      self.notify({
        action: :create,
        data: self.build_data(user, s)
      })
    end
  end

  def self.notify_update(user)
    user.subscriptions.includes(:accreditation, course: [:course_sessions]).each do |s|
      self.notify({
        action: :update,
        data: self.build_data(user, s)
      })
    end
  end

  private

    def self.build_data(user, subscription)
      {
        email: user.email,
        name: user.name,
        partner_name: user.partner_name,
        country: user.country,
        created_at: user.created_at,
        notification_timestamp: DateTime.now,
        course: subscription.course.try(:name),
        accreditation: subscription.accreditation.try(:name),
        finished: subscription.finished,
        session_type: subscription.course.try(:session_type),
        next_date: subscription.course.try(:next_session),
        created_at: subscription.created_at
      }
    end
end
