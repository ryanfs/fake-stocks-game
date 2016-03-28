class HoldingsController < ApplicationController
  def new
    @stocks = Stock.all
  end

  def create
    Holding.buy_stocks(params[:holdings], current_user)
    flash[:error] = 'You do not have enough cash to make this trade! Try making smarter purchasing decisions...'
    redirect_to markets_path
  end
end
