class Stock < ActiveRecord::Base
  include HTTParty

  validates :name, :price, presence: true
  validates :name, uniqueness: true
  has_many :markets
  has_many :holdings
  has_and_belongs_to_many :users, through: :holdings

  def self.stock_status(stock)
    response = HTTParty.get("https://www.quandl.com/api/v3/datasets/WIKI/#{stock}.json?api_key=JbeKoETbmEm1GaDYfsD1&limit=2&column_index=1")
    response.code
  end

  def self.stock_price(stock)
    response = HTTParty.get("https://www.quandl.com/api/v3/datasets/WIKI/#{stock}.json?api_key=JbeKoETbmEm1GaDYfsD1&limit=2&column_index=1")
    response["dataset"]["data"][0][1]
  end

  def self.add_to_market(name, price)
    Stock.create({name: name, symbol: name, price: price})
  end

  def self.update_stock_prices
    stocks = Stock.all
    stocks.each do |stock|
      puts stock.name
      stock_object = StockQuote::Stock.quote(stock.symbol)
      puts stock_object.ask
      if stock_object.response_code == 200
        stock.update(price: stock_object.ask, name: stock_object.name)
      else
        puts stock.name
      end
    end
  end


    #https://www.quandl.com/api/v3/datasets/WIKI/mkc.json?api_key=JbeKoETbmEm1GaDYfsD1&limit=2&column_index=1&transform=diff
end
