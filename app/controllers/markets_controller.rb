class MarketsController < ApplicationController

  def index
    @users = User.all
    @stocks = Stock.all
  end

end
