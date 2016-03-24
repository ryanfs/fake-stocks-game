class Portfolio < ActiveRecord::Base
  belongs_to :user
  has_many :stocks, through: :portfolios_stocks
  has_many :portfolios_stocks

  #delegate :stocks, to: :user
end
