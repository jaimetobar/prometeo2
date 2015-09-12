class PlanMailer < ApplicationMailer
  default from: "cromero@redhat.com"

  def plan_greatings_email(user)
    @user = user
    @sessions_per_course = Course.sessions_per_course(user.courses)
    mail(
      from: sender_for(@user),
      to: @user.email,
      subject: 'Plan de Acreditaciones de Red Hat')
  end

  def upcoming_courses_email(user, subscriptions_ids ,start_date)
    @user = user
    # TODO:
    # I'm collectiong ids because there's something that fails with sidekik
    # when I try to send the subscriptions as an ActiveRecord Asociation.
    # I guess that it has to do with serialization of the object
    @subscriptions =  Subscription.where(id: subscriptions_ids)
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
