class User < ApplicationRecord
  validates :username, :email, :password, presence: true
  validates :email, format: URI::MailTo::EMAIL_REGEXP, uniqueness: true
  validates :password, confirmation: true
end
