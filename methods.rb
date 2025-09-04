# frozen_string_literal: true

def my_name
  'Wikkrau'
end

def greet(name = 'Stranger')
  "Hello, #{name}!"
end
puts greet(my_name)
puts greet

def even_odd(number)
  return 'A number was not entered.' unless number.is_a? Numeric

  if number.even?
    'That is an even number.'
  else
    'That is an odd number.'
  end
end

puts even_odd(20) #=>  That is an even number.
puts even_odd('Ruby') #=>  A number was not entered.

dictionary = 'abcdefghijklmnopqrstuvwxyz'
dictionary = dictionary.split('')
word = 'hello'
word = word.split('')

def word_to_array(word, dictionary)
  word.map do |letter|
    dictionary.index(letter)
  end
end
puts word_to_array(word, dictionary) #=> [7, 4, 11, 14, 17]
