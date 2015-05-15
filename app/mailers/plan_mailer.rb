class PlanMailer < ActionMailer::Base
  default from: ENV["SMTP_FROM"] || "no-reply@prometeo.com"

  def plan_greatings_email(user)
    @user = user
    mail(to: @user.email,
       subject: 'Plan de cursos Prometeo')
  end

  def notifications_email(user, courses_session ,start_date)
    @days_left = (start_date - Time.now.to_date).to_i
    @user = user
    @courses_session =  courses_session
    mail(to: @user.email,
       subject: 'Notificación de Curso por Comenzar')
  end
end
