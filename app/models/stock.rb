class Stock < ActiveRecord::Base
  validates :name, :price, presence: true
  validates :name, uniqueness: true
  has_many :markets
  has_many :holdings
  has_and_belongs_to_many :users, through: :holdings
end
