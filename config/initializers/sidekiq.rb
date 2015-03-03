Sidekiq.configure_server do |config|
  config.redis = {:url => ENV['REDISTOGO_URL'], :namespace => ENV['SHORT_NAME']}
end

Sidekiq.configure_client do |config|
  config.redis = {:url => ENV['REDISTOGO_URL'], :namespace => ENV['SHORT_NAME']}
end

Sidekiq.configure_server do |config|
  config.poll_interval = 2
end
