class Api::VideoController < ApplicationController
  include ApplicationHelper

  def index
    result = ::VideoServices::GetVideoList.call(params)
    response_result(result)
  end

  def share
    result = ::VideoServices::YoutubeService.call(params)
    response_result(result)
  end
end
