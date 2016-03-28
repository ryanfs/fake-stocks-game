class Holding < ActiveRecord::Base
  belongs_to :user
  belongs_to :stock

  def self.buy_stocks(params, user)
    order_price = self.price_of_order(params)
    if order_price <= user.cash
      order = self.get_stocks_from_order(params)
      self.purchase_stocks(order, user, order_price)
    end

  end

  private

  def self.purchase_stocks(stock_order, user, price)
    stock_order.each do |stock, quantity|
      stock_object = Stock.find_by(name: stock)
      buy = Holding.new(quantity: quantity, user: user, stock: stock_object)
      if buy.save
        user.update(cash: user.cash - price)
      else
        @error = 'Something went wrong with this order. Please try again. Your account was not charged.'
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
