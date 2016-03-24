class PortfoliosStock < ActiveRecord::Base
  belongs_to :stock
  belongs_to :portfolio
end
