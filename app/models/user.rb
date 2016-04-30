class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:google_oauth2]
  # has_secure_password
  validates :email, :username, presence: true
  validates :username, uniqueness: true
  has_many :holdings
  has_many :stocks, through: :holdings

def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:provider => access_token.provider, :uid => access_token.uid ).first
    if user
      return user
    else
      registered_user = User.where(:email => access_token.info.email).first
      if registered_user
        return registered_user
      else
        user = User.create(name: data["name"],
          provider:access_token.provider,
          email: data["email"],
          uid: access_token.uid ,
          password: Devise.friendly_token[0,20],
        )
      end
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
