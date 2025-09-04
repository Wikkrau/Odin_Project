# frozen_string_literal: true

numbers = [5, 6, 7, 8]
element = 6
result = false

numbers.each do |number|
  if number == element
    result = true
    break
  end
end
# => true

element = 3
result = false

numbers.each do |number|
  if number == element
    result = true
    break
  end
end
#=> false
numbers = [5, 6, 7, 8]

numbers.include?(6)
#=> true

numbers.include?(3)
#=> false
friends = %w[Sharon Leo Leila Brian Arun]

invited_list = friends.reject { |friend| friend == 'Brian' }

invited_list.include?('Brian')
#=> false
#
# fruits = ["apple", "banana", "strawberry", "pineapple"]

fruits.none? { |fruit| fruit.length > 10 }
#=> true

fruits.none? { |fruit| fruit.length > 6 }
#=> false
