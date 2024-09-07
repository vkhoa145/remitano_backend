class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token
  before_action :set_current_user
  
  include ApplicationHelper

  private

  def set_current_user
    header = request.headers['Authorization']
    token = header&.split&.last
    GetCurrentUser.new(token).call
  end
end
