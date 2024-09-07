module ApplicationHelper
  def response_result(result)
    return response_error(result.error, result.code) if result.error?

    render json: result.data, status: result.code
  end

  def response_error(error, code)
    render json: error, status: code
  end
end
