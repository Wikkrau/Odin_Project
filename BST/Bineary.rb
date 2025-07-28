class Tree
  def initialize(array = [])
    @root = build_tree(array)
  end

  def build_tree(array)
    return nil if array.empty?

    sorted = array.sort.uniq
    mid = sorted.length / 2
    root = Node.new(sorted[mid])

    root.left = build_tree(sorted[0...mid])
    root.right = build_tree(sorted[mid + 1..-1])

    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    return if node.nil?

    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  # insert method
  def insert(value)
    @root = insert_rec(@root, value)
  end

  def insert_rec(node, value)
    return Node.new(value) if node.nil?

    if value < node.value
      node.left = insert_rec(node.left, value)
    elsif value > node.value
      node.right = insert_rec(node.right, value)
    end

    node
  end

  # delete method
  def delete(value)
    @root = delete_rec(@root, value)
  end

  def delete_rec(node, value)
    return node if node.nil?

    if value < node.value
      node.left = delete_rec(node.left, value)
    elsif value > node.value
      node.right = delete_rec(node.right, value)
    else
      # Node with one child or no child
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      # Node with two children: get the inorder successor (smallest in the right subtree)
      min_larger_node = find_min(node.right)
      node.value = min_larger_node.value
      node.right = delete_rec(node.right, min_larger_node.value)
    end

    node
  end

  def find(value)
    find_rec(@root, value)
  end

  def find_rec(node, value)
    return false if node.nil?
    return true if value == node.value

    if value < node.value
      find_rec(node.left, value)
    else
      find_rec(node.right, value)
    end
  end
end

class Node
  attr_accessor :value, :left, :right

  def initialize(value)
    @value = value
    @left = nil
    @right = nil
  end
end
