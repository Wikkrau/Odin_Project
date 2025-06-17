# frozen_string_literal: true

def stock_picker(prices)
  best_days = []
  best_profit = 0
  prices.each_with_index do |day1, index1|
    prices.each_with_index do |day2, index2|
      profit = day2 - day1
      if profit.positive? && index2 > index1 && (profit > best_profit)
        best_profit = profit
        best_days = [index1, index2]
      end
    end
  end
  best_days.inspect
end
puts stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])
