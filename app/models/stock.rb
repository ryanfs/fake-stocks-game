class Stock < ActiveRecord::Base
  validates :name, :price, presence: true
  has_many :markets
  has_and_belongs_to_many :portfolios, through: :portfolios_stocks
  has_many :portfolios_stocks
end
