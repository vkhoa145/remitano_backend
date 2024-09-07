class ResultData
  attr_accessor :data, :error, :code

  def initialize(data: nil, error: nil, code: 200)
    @data = data
    @error = error
    @code = code
  end

  def error?
    error.present?
  end
end