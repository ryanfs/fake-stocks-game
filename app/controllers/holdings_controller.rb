class HoldingsController < ApplicationController
  def new
    @stocks = Stock.all
  end

  def create
    if (params.has_key?(:decision))
      Holding.sell_stocks(params[:holdings], current_user)
      redirect_to markets_path
    else
    Holding.buy_stocks(params[:holdings], current_user)
    redirect_to markets_path
    end
  end
end
