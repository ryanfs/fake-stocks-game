class User < ActiveRecord::Base
  has_secure_password
  validates :email, :username, presence: true
  has_many :stocks, through: :portfolios_stocks
  has_many :portfolios_stocks
end
