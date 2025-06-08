num = 2+2
puts "The value of num is: #{num}"
# Addition
1 + 1   #=> 2

# Subtraction
2 - 1   #=> 1

# Multiplication
2 * 2   #=> 4

# Division
10 / 5  #=> 2

# Exponent
2 ** 2  #=> 4
3 ** 4  #=> 81

# Modulus (find the remainder of division)
8 % 2   #=> 0  (8 / 2 = 4; no remainder)
10 % 4  #=> 2  (10 / 4 = 2 with a remainder of 2)
num=num.to_f # Convert to float
puts "The value of num as a float is: #{num}"
puts "The value of num as a string is: #{num.to_i.to_s}"
name = "John"
puts "Hello, #{name}!"  # String interpolation
puts 'Hello, #{name}!'  # No interpolation, prints literally