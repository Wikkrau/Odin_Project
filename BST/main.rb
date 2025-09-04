require_relative 'Bineary'

values = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

tree = Tree.new(values)
tree.delete(8)
tree.pretty_print
puts "Inorder: #{tree.inorder}"
puts "Preorder: #{tree.preorder}"
puts "Postorder: #{tree.postorder}"
puts "Height: #{tree.height(@root)}"
puts "Balanced: #{tree.balanced?}"
puts "Depth of 4: #{tree.depth_of(4)}"
puts "Depth of 999: #{tree.depth_of(999)}"
tree.insert(8)
new_values = [1, 3, 4, 5, 7, 8, 9, 23, 67, 324, 6345, 999, 1000, 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1008, 1009,
              1010, 1011, 1012, 1013, 1014, 1015, 1016, 1017, 1018, 1019, 1020, 1021, 1022, 1023, 1024, 1025]
tree.build_tree(new_values)
tree.pretty_print
if tree.balanced?
  puts 'Tree is balanced'
else
  puts 'Tree is not balanced, rebalancing...'
end
tree.rebalance
puts 'Rebalanced tree:'
tree.pretty_print
