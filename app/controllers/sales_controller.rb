class SalesController < ApplicationController
  require 'pry'
  def new
    @stocks = Stock.all
    render new_sale_path
  end

  def create
    # // submit this with ajax to serve errors properly
    Sale.sell_stocks(params[:sales], current_user)
    redirect_to markets_path
  end


end
