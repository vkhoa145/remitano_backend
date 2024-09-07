class Video < ApplicationRecord
  YOUTUBE_URL_REGEX = /\A(http|https):\/\/(www\.)?youtube\.com\/.+\z/

  belongs_to :user
  
  validates :url, presence: true, format: { with: YOUTUBE_URL_REGEX }
end
