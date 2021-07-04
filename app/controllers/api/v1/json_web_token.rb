module Api
  module V1
    class JsonWebToken
      SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
      EXPIRES_IN = 15

      def self.encode(payload, exp = default_duration)
        payload[:exp] = exp
        JWT.encode(payload, SECRET_KEY)
      end

      def self.decode(token)
        decoded = JWT.decode(token, SECRET_KEY)[0]
        HashWithIndifferentAccess.new decoded
      end

      def self.default_duration
        EXPIRES_IN.second.from_now.to_i
      end

      def self.expires_in
        default_duration - Time.now.to_i
      end
    end
  end
end
