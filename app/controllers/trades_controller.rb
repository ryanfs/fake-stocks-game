class TradesController < ApplicationController
  require 'pry'
  def new
    @stocks = Stock.all
    render new_trade_path
  end

  def create
    # // submit this with ajax to serve errors properly
    Trade.buy_stocks(params[:trades], current_user)
    redirect_to markets_path
  end


end
