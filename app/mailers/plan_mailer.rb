class PlanMailer < ActionMailer::Base
  default from: ENV["SMTP_FROM"] || "no-reply@prometeo.com"

  def plan_greatings_email(user)
    @user = user
    @sessions_per_course = Course.sessions_per_course(user.courses)
    mail(to: @user.email,
       subject: 'Plan de cursos Prometeo')
  end

  def notifications_email(user, subscriptions ,start_date)
    @user = user
    @subscriptions =  subscriptions
    @start_date = start_date
    mail(to: @user.email,
       subject: 'Prometeo - Notificación de Cursos por Comenzar')
  end
end
