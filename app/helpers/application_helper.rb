module ApplicationHelper
  def country_priority
    ["BR","MX","AR","CL","CO","AW","BB","BO","BS","BZ","CR","CU","CW","DM","DO","EC","GT","GY","HN","HT","JM","KY","LC","MF","MQ","MS","NI","PA","PE","PR","PY","SR","SV","SX","TC","TT","UY","VE"]
  end

  def locale_link(locale)
    uri = URI request.original_url
    params_hash = {}
    Rack::Utils.parse_query(uri.query).each do |k,v|
      params_hash[k.gsub("[]","")] = v
    end
    uri.query = params_hash.merge("locale" => locale).to_query
    uri.to_s
  end
end
