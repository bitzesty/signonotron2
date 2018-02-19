# require "sidekiq"

# if ENV['VCAP_SERVICES'].present?
#   services = JSON.parse(ENV['VCAP_SERVICES'])
#   if services['redis'].present?
#     credentials = services['redis'].first['credentials']
#     ENV['REDIS_URL'] = "redis://:#{credentials['password']}@#{credentials['host']}:#{credentials['port']}/"
#   end
# end

# redis_config = { namespace: "signon_sidekiq" }
# redis_config[:url] = ENV['REDIS_URL'] if ENV['REDIS_URL']

# Sidekiq.configure_server do |config|
#   config.redis = redis_config
#   config.server_middleware do |chain|
#     chain.add Sidekiq::Statsd::ServerMiddleware, env: 'govuk.app.signon', prefix: 'workers'
#   end
# end

# Sidekiq.configure_client do |config|
#   config.redis = redis_config
# end

require "sidekiq"

# PaaS Redis is not ready for prod
if ENV['VCAP_SERVICES'].present?
  redis_url = JSON.parse(ENV["VCAP_SERVICES"])["user-provided"].select{ |s| s["name"] == "redis-alpha" }[0]["credentials"]["uri"]
else
  redis_url = ENV["REDIS_URL"]
end

redis_db = ENV["REDIS_DB"] || 0

redis_config = { url: redis_url, db: redis_db }

Sidekiq.configure_server do |config|
  config.redis = redis_config
end

Sidekiq.configure_client do |config|
  config.redis = redis_config
end
