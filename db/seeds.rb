# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

stocks = ['goog',
'fb',
'tsla',
'nke',
'amzn',
'yhoo']

StockQuote::Stock.quote("goog")
response_code

stocks.each do |stock|
  status = Stock.stock_status(stock)
  if status == 200
    Stock.add_to_market(stock, Stock.stock_price(stock))
  else
    puts stock
  end
end

ryan = User.create({username: 'ryan', email: 'rfsalerno@gmail.com', password_digest: 'southpark'})