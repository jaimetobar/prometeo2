module ApplicationHelper
  def country_priority
    ["BR","MX","AR","CL","CO","AW","BB","BO","BS","BZ","CR","CU","CW","DM","DO","EC","GT","GY","HN","HT","JM","KY","LC","MF","MQ","MS","NI","PA","PE","PR","PY","SR","SV","SX","TC","TT","UY","VE"]
  end

  def locale_link(locale)
    uri = URI request.original_url
    if uri.path =~ /^\/(#{Settings.locales.join('|')})\/.*/
      uri.path = URI.escape uri.path.sub($1,locale)
    else
      uri.path = URI.escape "/#{locale}#{uri.path}"
    end
    uri.to_s
  end
end
