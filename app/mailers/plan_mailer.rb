class PlanMailer < ActionMailer::Base
  default from: "no-reply@prometeo.com"
  def plan_greatings(user)
    @user = user
    mail(to: @user.email,
       subject: 'Plan de cursos Prometeo') 

  end
end
