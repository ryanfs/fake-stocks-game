class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:google]
  # has_secure_password
  validates :email, :username, presence: true
  validates :username, uniqueness: true
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

  def self.portfolio_value(user)
    total_value = 0
    stock_value = user.holdings.group(:stock_id).sum(:quantity).map do |stock_id, quantity|
      stock = Stock.find(stock_id)
      stock.price.to_f * quantity
    end
    stock_value.each do |stock_price|
      total_value += stock_price
    end
    total_value
  end

  def self.leaderboard
    users = User.all
    leaderboard = {}
    users.each do |user|
      username = user.username
      puts "ryan #{portfolio_value(user)}"
      my_portfolio_value = user.cash.to_f
      my_portfolio_value += portfolio_value(user)
      leaderboard[username] = my_portfolio_value.round(2)
    end
    leaderboard.sort_by {|_key, value| value}.reverse
  end
end
