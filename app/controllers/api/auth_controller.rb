class Api::AuthController < ApplicationController
  def index
    render json: { message: 'oke'}, status: :ok
  end

  def create
    result = ::AuthServices::Authenticate.call(params)
    response_result(result)
  end
end
