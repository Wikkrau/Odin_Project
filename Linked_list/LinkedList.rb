class LinkedList
  def initialize
    @head = nil
  end

  def append(value)
    new_node = Node.new(value)
    if @head.nil?
      @head = new_node
    else
      current = @head
      current = current.next while current.next
      current.next = new_node
      new_node.prev = current
    end
  end

  def print_list
    current = @head
    while current
      print "#{current.value} -> "
      current = current.next
    end
    puts 'nil'
  end

  def prepend(value)
    new_node = Node.new(value)
    if @head.nil?
      @head = new_node
    else
      new_node.next = @head
      @head.prev = new_node
      @head = new_node
    end
  end

  def size
    count = 0
    current = @head
    until current.nil?
      count += 1
      current = current.next
    end
    count
  end

  # head return
  def head
    return nil if @head.nil?

    current = @head
    current = current.prev while current.prev
    current
  end

  def tail
    return nil if @head.nil?

    current = @head
    current = current.next while current.next
    current
  end

  def at(index)
    return nil if index < 0

    current = @head
    count = 0
    while current
      return current if count == index

      current = current.next
      count += 1
    end
    nil
  end

  def pop
    return nil if @head.nil?

    if @head.next.nil?
      value = @head.value
      @head = nil
      return value
    end

    current = @head
    current = current.next while current.next
    value = current.value
    current.prev.next = nil
    current.prev = nil
    value
  end

  def contains?(value)
    current = @head
    while current
      return true if current.value == value

      current = current.next
    end
    false
  end

  def find(value)
    current = @head
    index = 0
    while current
      return index if current.value == value

      current = current.next
      index += 1
    end
    nil
  end

  def to_s
    current = @head
    result = []
    while current
      result << current.value
      current = current.next
    end
    result.join(' -> ')
  end

  def insert_at(index, value)
    return if index < 0

    new_node = Node.new(value)
    if index == 0
      prepend(value)
      return
    end

    current = @head
    count = 0
    while current && count < index - 1
      current = current.next
      count += 1
    end

    return unless current

    new_node.next = current.next
    new_node.prev = current
    current.next.prev = new_node if current.next
    current.next = new_node
  end

  def remove_at(index)
    return if index < 0 || @head.nil?

    if index == 0
      @head = @head.next
      @head.prev = nil if @head
      return
    end

    current = @head
    count = 0
    while current && count < index
      current = current.next
      count += 1
    end

    return unless current

    current.prev.next = current.next if current.prev
    current.next.prev = current.prev if current.next
  end
end
