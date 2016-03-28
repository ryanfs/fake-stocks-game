class Holding < ActiveRecord::Base
  belongs_to :user
  belongs_to :stock

  def self.buy_stocks(params, user)
    order_price = self.price_of_order(params)
    if order_price <= user.cash
      order = self.get_stocks_from_order(params)
      self.purchase_stocks(order, user, order_price)
    else
      flash[:error] = 'You do not have enough cash to make this trade! Try making smarter purchasing decisions...'
    end
  end

  def self.sell_stocks(params, user)
    order_price = self.price_of_order(params)
    order = self.get_stocks_from_order(params)
    self.sell(order, user, order_price)
  end

  private

  def self.sell(stock_order, user, price)
    stock_order.each do |stock, quantity|
      (quantity = quantity * -1)
      stock_object = Stock.find_by(name: stock)
      sell = Holding.new(quantity: quantity, user: user, stock: stock_object)
      if sell.save
        user.update(cash: user.cash + price)
      else
        flash[:error] = 'Something went wrong with this order. Please try again.'
      end
    end
  end

  def self.purchase_stocks(stock_order, user, price)
    stock_order.each do |stock, quantity|
      stock_object = Stock.find_by(name: stock)
      buy = Holding.new(quantity: quantity, user: user, stock: stock_object)
      if buy.save
        user.update(cash: user.cash - price)
      else
        flash[:error] = 'Something went wrong with this order. Please try again. Your account was not charged.'
      end
    end
  end

  def self.price_of_order(params)
    total_price = 0
    params.each do |name, val|
      total_price += (val.to_i * Stock.find_by(name: name).price)
    end
    total_price
  end


  def self.get_stocks_from_order(params)
    stock_order = {}
    params.each do |key, val|
      val = val.to_i
      stock_order[key] = val if val > 0
    end
    stock_order
  end

end
