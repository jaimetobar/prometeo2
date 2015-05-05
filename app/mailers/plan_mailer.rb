class PlanMailer < ActionMailer::Base
  default from: "no-reply@prometeo.com"

  def plan_greatings(user)
    @user = user
    mail(to: @user.email,
       subject: 'Plan de cursos Prometeo') 
  end  
  def notifications(user, courses_session ,start_date)
    @days_left = (start_date - Time.now.to_date).to_i
    @user = user
    @courses_session =  courses_session
    mail(to: @user.email,
       subject: 'Notificación de Curso por Comenzar') 
  end
end
