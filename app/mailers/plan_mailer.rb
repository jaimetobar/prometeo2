class PlanMailer < ActionMailer::Base
  default from: "cromero@redhat.com"
  add_template_helper(PlanMailerHelper)

  def plan_greatings_email(user)
    @user = user
    @sessions_per_course = Course.sessions_per_course(user.courses)
    mail(
      from: sender_for(@user),
      to: @user.email,
      subject: 'Plan de Acreditaciones de Red Hat')
  end

  def notifications_email(user, subscriptions ,start_date)
    @user = user
    @subscriptions =  subscriptions
    @start_date = start_date
    mail(
      from: sender_for(@user),
      to: @user.email,
      subject: 'Recordatorio de cursos disponibles de Red Hat')
  end

  private
  def sender_for(user)
    case user.country
    when "MX"
      "monicaos@redhat.com"
    else
      "cromero@redhat.com"
    end
  end
end
