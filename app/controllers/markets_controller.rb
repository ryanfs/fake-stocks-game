class MarketsController < ApplicationController

  def index
    @users = User.all
    @stocks = Stock.all
    @stock = Stock.new
    @user_holdings = current_user.holdings
  end

  def stockmarket
    @stock = Stock.new
    @stocks = Stock.all
    #Stock.update_stock_prices
  end


end
