class MarketsController < ApplicationController

  def index
    @users = User.all
    @stocks = Stock.all
    @user_holdings = current_user.holdings
  end

end
