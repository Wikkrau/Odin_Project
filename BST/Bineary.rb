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

      return node.right if node.left.nil?
      return node.left if node.right.nil?

      min_larger_node = find_min(node.right)
      node.value = min_larger_node.value
      node.right = delete_rec(node.right, min_larger_node.value)
    end

    node
  end

  def find_min(node)
    node = node.left while node.left
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

  # ______________________________________________________________________________
  def level_order(&block)
    return [] if @root.nil?

    result = []
    queue = [@root]

    until queue.empty?
      node = queue.shift

      if block_given?
        yield(node.value)
      else
        result << node.value
      end

      queue << node.left if node.left
      queue << node.right if node.right
    end

    result unless block_given?
  end

  def traverse_level(node, level, result)
    return if node.nil?

    if level == 0
      result << node.value
    else
      traverse_level(node.left, level - 1, result)
      traverse_level(node.right, level - 1, result)
    end
  end

  def height(node)
    return -1 if node.nil?

    [height(node.left), height(node.right)].max + 1
  end

  # Inorder: Left → Root → Right
  def inorder(node = @root, &block)
    return [] if node.nil?

    result = []

    left_result = inorder(node.left, &block)
    result.concat(left_result) unless block_given?

    if block_given?
      yield(node.value)
    else
      result << node.value
    end

    right_result = inorder(node.right, &block)
    result.concat(right_result) unless block_given?

    result unless block_given?
  end

  # Preorder: Root → Left → Right
  def preorder(node = @root, &block)
    return [] if node.nil?

    result = []

    if block_given?
      yield(node.value)
    else
      result << node.value
    end

    left_result = preorder(node.left, &block)
    result.concat(left_result) unless block_given?

    right_result = preorder(node.right, &block)
    result.concat(right_result) unless block_given?

    result unless block_given?
  end

  # Postorder: Left → Right → Root
  def postorder(node = @root, &block)
    return [] if node.nil?

    result = []

    left_result = postorder(node.left, &block)
    result.concat(left_result) unless block_given?

    right_result = postorder(node.right, &block)
    result.concat(right_result) unless block_given?

    if block_given?
      yield(node.value)
    else
      result << node.value
    end

    result unless block_given?
  end

  def height_of_tree
    height(@root)
  end

  def depth_of(value)
    depth_rec(@root, value, 0)
  end

  def depth_rec(node, value, depth = 0)
    return nil if node.nil?

    return depth if node.value == value

    if value < node.value
      depth_rec(node.left, value, depth + 1)
    else
      depth_rec(node.right, value, depth + 1)
    end
  end

  def balanced?
    balanced_rec(@root)
  end

  def balanced_rec(node)
    return true if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    if (left_height - right_height).abs <= 1 &&
       balanced_rec(node.left) && balanced_rec(node.right)
      true
    else
      false
    end
  end

  def rebalance
    return if balanced?

    values = inorder
    @root = build_tree(values)
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
