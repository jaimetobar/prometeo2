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
      """
<br />
<small>¿Tienes problemas de acceso?: #{link_to 'Acá', 'http://bit.ly/partner_sac_faq'} encontrarás respuestas a tus posibles inquietudes.</small><br />
<small>¿Dudas adicionales? Escríbenos:</small>
<small>#{mail_to 'cromero@redhat.com'} | #{mail_to 'jtobar@redhat.com'}</small><br />
      """.html_safe
    end
  end
end
