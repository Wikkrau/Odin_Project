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
end
