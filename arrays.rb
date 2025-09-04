# frozen_string_literal: true

str_array = %w[apple banana cherry]
int_array = [1, 2, 3, 4, 5]

puts str_array[0]  # Accessing the first element
puts int_array[2]  # Accessing the third element
puts str_array[-1] # Accessing the last element
puts int_array[1..3] # Accessing a range of elements (second to fourth)

sub_array = [1, 1, 1, 2, 2, 2, 3, 4, 4] - [1, 1, 4]
puts sub_array.inspect # Output the modified array

array.new
array.new(5) # Creates an empty array with a size of 5
array.new(5, 0) # Creates an array of size 5, initialized with 0

num_array = [1, 2]

num_array.push(3, 4)      #=> [1, 2, 3, 4]
num_array << 5            #=> [1, 2, 3, 4, 5]
num_array.pop             #=> 5
puts num_array.inspect    #=> [1, 2, 3, 4]

num_array = [2, 3, 4]
num_array.unshift(1)
puts num_array.inspect
num_array.shift
puts num_array.inspect

a = [1, 2, 3]
b = [4, 5, 6]
puts a + b          # Concatenates two arrays
puts a - b          # Subtracts elements of b from a
