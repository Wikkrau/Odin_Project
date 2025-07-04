# frozen_string_literal: true

def bubble_sort(arr)
  n = arr.length
  loop do
    swapped = false
    (n - 1).times do |i|
      if arr[i] > arr[i + 1]
        arr[i], arr[i + 1] = arr[i + 1], arr[i] # swap
        swapped = true
      end
    end
    break unless swapped
  end
  arr
end
puts bubble_sort([4, 3, 78, 2, 0, 2])
