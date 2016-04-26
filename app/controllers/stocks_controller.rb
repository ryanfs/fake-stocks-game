class StocksController < ApplicationController

  def index
    @stocks = Stock.all
    Stock.update_stock_prices
  end

  def show
  end

  def new
    @stock = Stock.new
  end

  def create
    name = params["stock"]["name"]
    stock = StockQuote::Stock.quote(name)
    status = stock.response_code
    if status == 200
      Stock.add_to_market(name)
      redirect_to markets_path
    else
      puts name
    end
  end
end
