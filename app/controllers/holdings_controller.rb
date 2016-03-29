class HoldingsController < ApplicationController
  def new
    @stocks = Stock.all
  end

  def create
    if (params.has_key?(:decision))
      if Holding.sell_stocks(params[:holdings], current_user)
        redirect_to markets_path
      else
        redirect_to markets_path, :flash => { :error => "Something went wrong, please try again. Your account was not charged." }
      end
    else
      if Holding.buy_stocks(params[:holdings], current_user)
        redirect_to markets_path
      else
        redirect_to markets_path, :flash => { :error => 'You do not have enough cash to make this trade! Try making smarter purchasing decisions...' }
      end
    end
  end
end
