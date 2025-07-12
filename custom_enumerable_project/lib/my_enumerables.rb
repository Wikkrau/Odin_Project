module Enumerable
  def my_each_with_index
    index = 0
    my_each do |element|
      yield(element, index)
      index += 1
    end
    self
  end

  def my_select
    result = []
    my_each do |element|
      result << element if yield(element)
    end
    result
  end

  def my_all?
    my_each do |element|
      return false unless yield(element)
    end
    true
  end

  def my_any?
    my_each do |element|
      return true if yield(element)
    end
    false
  end

  def my_count
    count = 0
    if block_given?
      my_each { |element| count += 1 if yield(element) }
    else
      my_each { count += 1 }
    end
    count
  end

  def my_map
    result = []
    my_each do |element|
      result << if block_given?
                  yield(element)
                else
                  element
                end
    end
    result
  end

  def my_inject(initial = nil)
    acc = initial.nil? ? self[0] : initial
    i = initial.nil? ? 1 : 0
    while i < length
      acc = yield(acc, self[i])
      i += 1
    end
    acc
  end

  def my_none?
    my_each do |element|
      return false if yield(element)
    end
    true
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    for element in self
      yield(element)
    end
    self
  end
end
