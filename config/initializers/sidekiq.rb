Sidekiq.configure_server do |config|
  if Rails.env == 'development'
    config.redis = { :url => 'redis://192.168.0.57:6379/12', :namespace => "feeder-web_development" }
  else
    config.redis = { :url => 'redis://redis.feeder.x:6379/12', :namespace => "feeder-web_production" }
  end
end

Sidekiq.configure_client do |config|
  if Rails.env == 'development'
    config.redis = { :url => 'redis://192.168.0.57:6379/12', :namespace => "feeder-web_development" }
  else
    config.redis = { :url => 'redis://redis.feeder.x:6379/12', :namespace => "feeder-web_production" }
  end
end
