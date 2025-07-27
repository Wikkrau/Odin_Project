require_relative 'constants'

class HashMap
  include Settings

  def initialize(capacity = CAPACITY, load_factor = LOAD_FACTOR)
    @capacity = capacity
    @load_factor = load_factor
    @buckets = Array.new(@capacity) { [] }
    @size = SIZE
  end

  def hash(key)
    hash_code = 0
    prime = 31
    key.each_char { |char| hash_code = prime * hash_code + char.ord }
    hash_code.abs
  end

  def bucket_index(key)
    hash(key) % @capacity
  end

  def need_resize?
    (@size.to_f / @capacity) >= LOAD_FACTOR
  end

  def resize!
    old_buckets = @buckets.flatten(1)
    @capacity *= 2
    @buckets = Array.new(@capacity) { [] }
    @size = 0

    old_buckets.each do |key, value|
      set(key, value)
    end
  end

  def set(key, value)
    resize! if need_resize?

    index = bucket_index(key)
    bucket = @buckets[index]

    bucket.each_with_index do |(k, _), i|
      if k == key
        bucket[i] = [key, value]
        return
      end
    end

    bucket << [key, value]
    @size += 1
  end

  def get(key)
    index = bucket_index(key)
    bucket = @buckets[index]

    bucket.each do |ke, val|
      return val if ke == key
    end

    nil
  end

  def delete(key)
    index = bucket_index(key)
    bucket = @buckets[index]

    bucket.each_with_index do |(k, _), i|
      next unless k == key

      bucket.delete_at(i)
      @size -= 1
      return true
    end

    false
  end

  def has?(key)
    index = bucket_index(key)
    bucket = @buckets[index]

    bucket.any? { |k, _| k == key }
  end

  def remove(key)
    index = bucket_index(key)
    bucket = @buckets[index]

    bucket.each_with_index do |(k, _), i|
      next unless k == key

      bucket.delete_at(i)
      @size -= 1
      return true
    end

    false
  end

  def length
    counter = 0
    @buckets.each do |bucket|
      counter += bucket.length
    end
    counter
  end

  def clear
    @buckets = Array.new(@capacity) { [] }
    @size = 0
  end

  # Flat_map or flatten ? I use flat_map to keep it clean and scalable but flatten is also an option
  # This is a method to get all keys, values, or entries in the hashmap
  # Just for my reference HIHI
  def keys
    @buckets.flat_map do |bucket|
      bucket.map { |key, _| key }
    end
  end

  def values
    @buckets.flat_map do |bucket|
      bucket.map { |_, value| value }
    end
  end

  def entries
    @buckets.flat_map do |bucket|
      bucket.map { |key, value| [key, value] }
    end
  end

  def key?(key)
    index = bucket_index(key)
    bucket = @buckets[index]

    bucket.any? { |k, _| k == key }
  end
end
