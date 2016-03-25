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
      stocks = my_stocks.group(:name).count.map do |name, count|
        "#{count} shares of #{name}"
      end
    else
      'Your portfolio is empty.'
    end

  end



end
