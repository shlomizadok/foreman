object @smart_proxy

node :success do
  locals[:success]
end

@smart_proxy.feature_names.each do |feature|
  feature = feature.parameterize('_')
  node(feature) { partial("api/v2/smart_proxies/plugins/#{feature}", :object => @statuses[feature.to_sym] || @smart_proxy) } if lookup_context.template_exists?("api/v2/smart_proxies/plugins/#{feature}", [], true)
end


