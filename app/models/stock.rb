class Stock < ActiveRecord::Base
  include HTTParty

  validates :name, :price, presence: true
  validates :name, uniqueness: true
  has_many :markets
  has_many :holdings
  has_and_belongs_to_many :users, through: :holdings

  def self.add_to_market(name)
    stock_object = StockQuote::Stock.quote(name)
    Stock.find_or_create_by({name: stock_object.name, symbol: stock_object.symbol, price: stock_object.ask})
  end

  def self.update_stock_prices
    stocks = Stock.all
    stocks.each do |stock|
      puts stock.name
      stock_object = StockQuote::Stock.quote(stock.symbol)
      puts stock_object.ask
      if stock_object.response_code == 200
        stock.update(price: stock_object.ask, name: stock_object.name, symbol: stock_object.symbol)
      else
        puts stock.name
      end
    end
  end

end
