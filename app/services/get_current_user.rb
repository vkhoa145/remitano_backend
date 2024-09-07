class GetCurrentUser
  @@current_user = nil

  def initialize(token)
    @token = token
  end

  def self.get_current_user
    @@current_user
  end

  def call
    return response_error(401, 'token is blank') if @token.blank?
    return response_error(401, 'Unauthorized Request') unless decode_token.present?

    set_current_user
  end

  private

  def decode_token
    JwtServices::JsonWebToken.decode(@token)
  end

  def user
    @user ||= User.find_by(id: decode_token[:user_id])
  end

  def set_current_user
    @@current_user = user
  end

  def response_error(code, message)
    ResultData.new(error: { code: code, message: message }, code: code)
  end
end