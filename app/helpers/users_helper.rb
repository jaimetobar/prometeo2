module UsersHelper
  def next_session(course)
    return "Siempre disponible" if course.always_available?

    if course.next_session.nil?
      "No disponible"
    else
      course.next_session.start_date
    end

  end
end
