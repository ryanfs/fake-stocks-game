class MarketsController < ApplicationController

  def index
    @users = User.all
    @leaderboard_users = User.order("cash DESC").first(10)
    @stocks = Stock.all
    @stock = Stock.new
    @user_holdings = current_user.holdings
    #Stock.update_stock_prices
  end


end
