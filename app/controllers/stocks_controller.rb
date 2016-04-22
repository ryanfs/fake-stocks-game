class StocksController < ApplicationController
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
      Stock.add_to_market(name, stock.ask)
      redirect_to markets_path
    else
      puts name
    end
  end
end
