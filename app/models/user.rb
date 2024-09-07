class User < ApplicationRecord
  EMAIL_REGEX = /\A(?:[\w+\-.*]+@[a-z\d\-.]+\.[a-z]+)?\z/i.freeze

  has_many :videos

  validates :email, :password, presence: true
  validates :email, uniqueness: true, format: { with: EMAIL_REGEX }

  has_secure_password :password
end
