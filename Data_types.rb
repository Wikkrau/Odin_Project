# frozen_string_literal: true

num = 2 + 2
puts "The value of num is: #{num}"
# Addition #=> 2

# Subtraction #=> 1

# Multiplication #=> 4

# Division #=> 2

# Exponent
2**2  #=> 4
3**4  #=> 81

# Modulus (find the remainder of division) #=> 0  (8 / 2 = 4; no remainder) #=> 2  (10 / 4 = 2 with a remainder of 2)
num = num.to_f # Convert to float
puts "The value of num as a float is: #{num}"
puts "The value of num as a string is: #{num.to_i}"
name = 'John'
puts "Hello, #{name}!"  # String interpolation
puts "Hello, #{name}!"  # No interpolation, prints literally
