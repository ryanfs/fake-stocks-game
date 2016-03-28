class User < ActiveRecord::Base
  has_secure_password
  validates :email, :username, presence: true
  has_many :holdings
  has_many :stocks, through: :holdings
end
