Sidekiq.configure_server do |config|
  config.redis = { url: "redis://192.168.0.57:6379/12", namespace: "feeder_dev" }
end

Sidekiq.configure_client do |config|
  config.redis = { url: "redis://192.168.0.57:6379/12", namespace: "feeder_dev" }
end
