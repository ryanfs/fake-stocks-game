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
    # look at every user, add up the value of their portfolio + cash holdings, return them in order
  end
end
