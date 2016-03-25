require 'pry'

class Trade < ActiveRecord::Base

  def self.buy_stocks(params, user)
    if price = can_afford_stocks?(user, params)
      selected_stocks = self.get_stocks_from_order(params)
      self.add_stocks_to_user(selected_stocks, user, price)
    else
      @error = 'You do not have enough cash to make that trade.'
    end
  end

  private

  def self.can_afford_stocks?(user, stocks    )
    stock_names = get_stocks_from_order(stocks)
    stock_objects = []
    stock_names.each do |name|
      stock_objects.push(Stock.find_by(name: name))
    end
    stock_prices = []
    stock_objects.each do |stock|
      stock_prices.push(stock.price)
    end
    total_price = stock_prices.reduce(:+)
    return false if user.cash < total_price
    return total_price
  end

  def self.get_stocks_from_order(params)
    selected_stocks = []
    params.each do |key, val|
      selected_stocks.push(key) if val === '1'
    end
    selected_stocks
  end

  def self.add_stocks_to_user(selected_stocks, user, price)
    purchased_stocks = []
    selected_stocks.each do |stock_name|
      purchased_stocks.push(Stock.find_by(name: stock_name))
    end
    user.stocks << purchased_stocks
    user.update(cash: user.cash - price)
  end

end
