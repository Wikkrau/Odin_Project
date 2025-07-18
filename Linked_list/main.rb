require_relative 'LinkedList'
require_relative 'node'

list = LinkedList.new
list.append(1)
list.append(2)
list.append('hello')
list.print_list
list.append(2)
list.prepend(2)
list.prepend(0)
list.print_list
puts "Size of the list: #{list.size}"
puts "Head of the list: #{list.head.value}" if list.head
puts "tail of the list: #{list.tail.value}" if list.tail

list.to_s
list.find(2) do |node|
  puts "Found node with value: #{node.value}"
end
if list.find(3)
  puts "Found node with value: #{list.find(3).value}"
else
  puts 'Node with value 3 not found'
end
if list.contains?(2)
  puts 'List contains the value 2'
else
  puts 'List does not contain the value 2'
end

list.remove_at(2)
list.print_list
list.insert_at(1, 3)
list.print_list
