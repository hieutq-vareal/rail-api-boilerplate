module RailApiBoilerplate
  class RedisClient
    PREFIX = "rail_api_boilerplate".freeze

    attr_reader :redis, :db

    def initialize(db = Settings.redis.db)
      @db = db
      @redis = Redis.new(redis_configuration)
    end

    def get(key)
      redis.get(namespaced_key(key))
    end

    def set(key, value, expiration_time = nil)
      expiration_time ? set_with_expiry(key, value, expiration_time) : set_without_expiry(key, value)
    end

    def delete(key)
      redis.del(namespaced_key(key))
    end

    def expire(key, expiration_time)
      redis.expire(namespaced_key(key), expiration_time)
    end

    def exists?(key)
      redis.exists(namespaced_key(key))
    end

    private

    def redis_configuration
      {
        host: Settings.redis.host,
        port: Settings.redis.port,
        db: db
      }
    end

    def set_with_expiry(key, value, expiration_time)
      redis.setex(namespaced_key(key), expiration_time, value)
    end

    def set_without_expiry(key, value)
      redis.set(namespaced_key(key), value)
    end

    def namespaced_key(key)
      "#{PREFIX}:#{key}"
    end
  end
end
