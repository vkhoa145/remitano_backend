module VideoServices
  class GetVideoList < BaseService
    def initialize(params)
      @params = params
    end

    def call
      result = {
        data: videos
      }
      ResultData.new(data: result, code: 200)
    rescue StandardError => e
      Rails.logger.fatal("AUTHENTICATE FAILED: #{e.message}")
      response_data_failed(500, e)
    end

    private

    def videos
      Video.order(id: :desc).includes(:user).all.map do |video|
        {
          id: video.id,
          title: video.title,
          url: video.url,
          description: video.description,
          like: video.like,
          dislike: video.dislike,
          user: video.user.email,
          youtube_id: video.youtube_id
        }
      end
    end
  end
end