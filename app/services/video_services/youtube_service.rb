require 'net/http'
require 'json'
require 'uri'

module VideoServices
  class YoutubeService < BaseService
    def initialize(params)
      @params = params
    end

    def call
      return response_data_failed(401, 'Unauthorized') unless current_user
      return response_data_failed(400, 'Url cannot be blank') if @params[:url].blank?
      return response_data_failed(400, 'Invalid Youtube format') unless valid_url?

      create_video
      result = {
        data: video_object
      }
      ResultData.new(data: result, code: 200)
    rescue StandardError => e
      Rails.logger.fatal("GET YOUTUBE VIDEO FAILED: #{e.message}")
      response_data_failed(500, e)
    end

    private

    def obtain_youtube_id
      @params[:url].match(/v=([^&]+)/)[1]
    end

    def video
      video_id = obtain_youtube_id
      url = URI("https://www.googleapis.com/youtube/v3/videos?part=snippet,statistics&id=#{video_id}&key=#{ENV['YOUTUBE_API_KEY']}")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      request = Net::HTTP::Get.new(url)
      response = http.request(request)
      @video ||= JSON.parse(response.body)
    end

    def video_object
      {
        youtube_id: video['items'][0]['id'],
        title: video['items'][0]['snippet']['title'],
        description: video['items'][0]['snippet']['description'],
        like: video['items'][0]['statistics']['likeCount'],
        dislike: video['items'][0]['statistics']['dislikeCount'],
        url: @params[:url]
      }
    end

    def create_video
      current_user.videos.create!(video_object)
    end

    def valid_url?
      return false unless Video::YOUTUBE_URL_REGEX.match?(@params[:url])

      true
    end
  end
end