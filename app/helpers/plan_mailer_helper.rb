module PlanMailerHelper
  def signature_for(user)
    case user.country
    when "MX"
      """
<br />
<small>¿Tienes problemas de acceso?: #{link_to 'Acá', 'http://bit.ly/partner_sac_faq'} encontrarás respuestas a tus posibles inquietudes.</small><br />
<br />
<small><strong>Mónica Osuna</strong></small><br />
<small><strong>Partner Enablement</strong></small><br />
<small><strong>T:  (55) 8851-6431 | M:  (55)  4848-0436</strong></small><br />
      """.html_safe
    else
      %Q(
Si necesitas ayuda adicional, aquí estamos. Sólo escríbenos a
</span><span style="font-size:14px; line-height:1.6em">&nbsp;
<a href="mailto:cromero@redhat.com,jaime@redhat.com?subject=Ayuda%20con%20mi%20plan%20de%20Entrenamiento" target="_blank">jaime@redhat.com /&nbsp;c</a>
</span><span style="font-size:14px; line-height:1.6em">
<a href="mailto:cromero@redhat.com,jaime@redhat.com?subject=Ayuda%20con%20mi%20plan%20de%20Entrenamiento">romero@redhat.com</a>
 y te ayudaremos de acuerdo a tu perfil y las acreditaciones ya aprobadas.</span>
      ).html_safe
    end
  end
end
