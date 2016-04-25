class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:google]
  # has_secure_password
  validates :email, :username, presence: true
  has_many :holdings
  has_many :stocks, through: :holdings


  def self.from_google(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
      end
  end

  def self.leaderboard
    users = User.all
    leaderboard = {}
    users.each do |user|
      username = user.username
      portfolio_value = user.cash.to_f
      user.stocks.each do |stock|
        portfolio_value += stock.price.to_f
      end
      leaderboard = username[portfolio_value]
    end
    leaderboard
  end
end
