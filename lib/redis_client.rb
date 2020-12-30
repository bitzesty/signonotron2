require "redis"

class RedisClient
  include Singleton

  attr_reader :connection

  def initialize
    @connection = Sidekiq.redis { |conn| conn }
  end
end
