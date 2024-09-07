module AuthServices
  class Authenticate < BaseService
    def initialize(params)
      @params = params
    end

    def call
      return response_data_failed(400, 'Email cannot be blank') if @params[:email].blank?
      return response_data_failed(400, 'Password cannot be blank') if @params[:password].blank?
      return response_data_failed(400, 'Email wrong format') unless valid_format_email?
      return response_data_failed(400, 'Wrong password') if user && !valid_password?

      result = {
        token: authenticate
      }
      ResultData.new(data: result, code: 200)
    rescue StandardError => e
      Rails.logger.fatal("AUTHENTICATE FAILED: #{e.message}")
      response_data_failed(500, e)
    end

    private

    def user
      @user ||= User.find_by(email: @params[:email])
    end

    def valid_format_email?
      return false unless User::EMAIL_REGEX.match?(@params[:email])

      true
    end

    def authenticate
      return login if user

      register
    end

    def login
      generate_access_token(user)
    end

    def register
      user = User.create(user_params)
      generate_access_token(user)
    end

    def valid_password?
      return unless user

      user.authenticate_password(@params[:password])
    end

    def generate_access_token(user)
      jwt_payload = {
        user_id: user.id,
        expires_at: 24.hours.from_now
      }

      JwtServices::JsonWebToken.encode(jwt_payload)
    end

    def user_params
      @params.permit(:email, :password)
    end
  end
end