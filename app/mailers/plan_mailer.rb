class PlanMailer < ApplicationMailer
  default from: "cromero@redhat.com"

  def plan_greatings_email(user)
    @user = user
    @sessions_per_course = Course.sessions_per_course(user.courses)
    template_name = template_for_user('plan_greatings_email', @user)
# TODO: Use locales for email text translation
#    I18n.with_locale(@user.profile.locale) do
#      mail :to=>@user.email
#    end
    mail(
      from: sender_for(@user),
      to: @user.email,
      subject: 'Plan de Acreditaciones de Red Hat',
      template_name: template_name)

  end

  def upcoming_courses_email(user, subscriptions_ids ,start_date)
    @user = user
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

    def template_for_user(template_name, user)
      if user.locale
        "#{template_name}_#{user.locale.downcase}"
      else
        template_name
      end
    end
end
