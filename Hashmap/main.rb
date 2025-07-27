require_relative 'Hashmap'
# Create a new HashMap
my_hash_map = HashMap.new

# Set key-value pairs
my_hash_map.set('name', 'John')
my_hash_map.set('age', 25)
my_hash_map.set('city', 'New York')

# Retrieve values
puts "Name: #{my_hash_map.get('name')}"
puts "Age: #{my_hash_map.get('age')}"
puts "City: #{my_hash_map.get('city')}"

# Display all keys, values, and entries
puts "All Keys: #{my_hash_map.keys}"
puts "All Values: #{my_hash_map.values}"
puts "All Entries: #{my_hash_map.entries}"

# Returns true or false based on whether or not the key is in the hash map
puts my_hash_map.key?('name') # true
puts my_hash_map.key?('age') # true
puts my_hash_map.key?('city') # true

puts my_hash_map.key?('hello') # false

# returns the number of stored keys in the hash map
puts my_hash_map.length # 3

my_hash_map.remove('name')
puts my_hash_map.length # 2
puts my_hash_map.get('name') # nil
puts my_hash_map.key?('name') # false

p my_hash_map.keys
p %w[age city]

# removes all entries in the hash map.
my_hash_map.clear

puts my_hash_map.length # 0
puts my_hash_map.keys # []
