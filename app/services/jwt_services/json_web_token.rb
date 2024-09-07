class JwtServices::JsonWebToken
  SECRET_KEY = ENV.fetch('SECRET_KEY_BASE')

  def self.encode(payload, exp = 30.minutes.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    body = JWT.decode(token, SECRET_KEY)[0]
    ActiveSupport::HashWithIndifferentAccess.new(body)
  rescue StandardError
    nil
  end
end
