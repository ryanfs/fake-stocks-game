module ApplicationHelper

  def my_stocks
    if current_user.stocks
      current_user.stocks
    else
      'Your portfolio is empty.'
    end
  end

  def my_portfolio
    if my_stocks
      current_user.holdings.group(:stock_id).sum(:quantity).map do |stock_id, quantity|
        stock = Stock.find(stock_id)
        "#{quantity} shares of #{stock.name}"
      end
    else
      'Your portfolio is empty.'
    end

  end



end
