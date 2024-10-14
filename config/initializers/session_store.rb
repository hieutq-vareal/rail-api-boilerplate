Rails.application.config.session_store :redis_store,
                                       servers: ["redis://#{Settings.redis.host}:#{Settings.redis.port}/#{Settings.redis.db}/session"],
                                       expire_after: 30.days,
                                       key: "_session_id",
                                       threadsafe: true,
                                       secure: Rails.env.production?,
                                       same_site: :none
