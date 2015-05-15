if Rails.env == "production"
  Sidekiq.configure_server do |config|
    config.redis = {
      url: "redis://#{ENV['OPENSHIFT_REDIS_HOST']}:#{OPENSHIFT_REDIS_PORT}/12",
      password: "#{ENV['REDIS_PASSWORD']}"
    }
  end

  Sidekiq.configure_client do |config|
    config.redis = {
      url: "redis://#{ENV['OPENSHIFT_REDIS_HOST']}:#{OPENSHIFT_REDIS_PORT}/12",
      password: "#{ENV['REDIS_PASSWORD']}"
    }
  end
end
