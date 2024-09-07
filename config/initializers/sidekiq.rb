require 'sidekiq'
require 'sidekiq/cron/web' if defined?(Sidekiq::Cron)

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'], password: ENV['REDIS_PASSWORD'] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'], password: ENV['REDIS_PASSWORD'] }
end
