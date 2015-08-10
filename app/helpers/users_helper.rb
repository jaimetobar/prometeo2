module UsersHelper
  def next_session(course)
    return I18n.t("admin.users.index.always_available") if course.always_available?

    if course.next_session.nil?
      I18n.t("admin.users.index.not_available")
    else
      course.next_session.start_date
    end

  end
end
