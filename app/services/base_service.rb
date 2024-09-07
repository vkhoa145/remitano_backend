class BaseService
  include ApplicationHelper

  def self.call(...)
    new(...).call
  end

  def current_user
    GetCurrentUser.get_current_user
  end

  def response_data_failed(code, message)
    ResultData.new(error: { code: code, message: message }, code: code)
  end

  def response_data_success(code, result)
    ResultData.new(code: code, data: result)
  end
end