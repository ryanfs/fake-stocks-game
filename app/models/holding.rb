class Holding < ActiveRecord::Base
  belongs_to :user
  belongs_to :stock

# View helper for holdings
  def self.buy_or_sell(num)
    if num > 0
      "Purchase"
    elsif num < 0
      "Sale"
    end
  end

Time::DATE_FORMATS[:custom_long_ordinal] = "%b %e, %Y @ %l:%M %p"

  def self.gain_loss(trade)
    if trade.quantity > 0
      "N/A"
    elsif trade.stock_price
      trade.stock_price - Stock.find_by(symbol: stock_symbol(trade.stock_id)).price
    else
      "N/A"
    end
  end

## end view helper for holdings

  def self.buy_stocks(params, user)
    order_price = self.price_of_order(params)
    puts "order_price #{order_price}"
    if order_price <= user.cash
      order = self.get_stocks_from_order(params)
      puts "order #{order}"
      self.purchase_stocks(order, user, order_price)
    else
      return false
    end
  end

  def self.sell_stocks(params, user)
    if self.user_cannot_have_negative_quantities_of_stock(user, params)
    else
      return false
    end
    order_price = self.price_of_order(params)
    order = self.get_stocks_from_order(params)
    self.sell(order, user, order_price)
  end

  def self.user_cannot_have_negative_quantities_of_stock(user, params)
    order = self.get_stocks_from_order(params)
    order.each do |stock, quantity|
      stock_id = Stock.find_by(symbol: stock).id
      if quantity > self.stock_quantity(user, stock_id)
        return false
      end
    end
  end

  private

  def self.stock_quantity(user, stock_id)
    stock_hash = user.holdings.group(:stock_id).sum(:quantity)
    return stock_hash[stock_id]
  end

  def self.sell(stock_order, user, price)
    stock_order.each do |stock, quantity|
      (quantity = quantity * -1)
      stock_object = Stock.find_by(symbol: stock)
      sell = Holding.new(quantity: quantity, user: user, stock: stock_object, stock_price: stock_object.price)
      if sell.save
        user.update(cash: user.cash - (stock_object.price * quantity))
      else
        return false
      end
    end
  end

  def self.purchase_stocks(stock_order, user, price)
    puts "stock order: #{stock_order} total price: #{price}"
    stock_order.each do |stock, quantity|
      puts stock
      stock_object = Stock.find_by(symbol: stock)
      buy = Holding.new(quantity: quantity, user: user, stock: stock_object, stock_price: stock_object.price)
      if buy.save
        user.update(cash: user.cash - (stock_object.price * quantity))
      else
        return false
      end
    end
  end

  def self.price_of_order(params)
    total_price = 0
    params.each do |name, val|
      total_price += (val.to_f * Stock.find_by(symbol: name).price)
    end
    puts "total price: #{total_price}"
    total_price
  end


  def self.get_stocks_from_order(params)
    stock_order = {}
    params.each do |key, val|
      val = val.to_f
      stock_order[key] = val if val > 0
    end
    stock_order
  end

  def self.stock_symbol(stock_id)
    stock = Stock.find(stock_id)
    stock.symbol
  end

end
