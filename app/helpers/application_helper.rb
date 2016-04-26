module ApplicationHelper

  def my_stocks
    if current_user.stocks
      current_user.stocks
    else
      'Your portfolio is empty.'
    end
  end

  def portfolio(user)
    if user.stocks
      user.holdings.group(:stock_id).sum(:quantity).map do |stock_id, quantity|
        stock = Stock.find(stock_id)
        worth = stock.price * quantity
        if quantity == 0
          0
        elsif quantity == 1
          "#{quantity} share of <strong>#{stock.name}</strong> worth <strong>$#{worth}</strong>"
        else
          "#{quantity} shares of <strong>#{stock.name}</strong> worth <strong>$#{worth}</strong>"
        end
      end
    end
  end

  def portfolio_value(user)
    value = 0
    user.holdings.group(:stock_id).sum(:quantity).map do |stock_id, quantity|
      stock = Stock.find(stock_id)
      worth = stock.price * quantity
      value += worth
    end
    value
  end

  def stocks(user)
    stocks_objects = []
    if user.stocks
      user.holdings.group(:stock_id).sum(:quantity).map do |stock_id, _quantity|
        stock = Stock.find(stock_id)
        stocks_objects << stock
      end
    end
    stocks_objects
  end

  def stock_name(stock_id)
    stock = Stock.find(stock_id)
    stock.name
  end

  def stock_symbol(stock_id)
    stock = Stock.find(stock_id)
    stock.symbol
  end

end
