def merge_sort(arr)
  return arr if arr.length <= 1

  mid = arr.length / 2
  left = merge_sort(arr[0...mid])
  right = merge_sort(arr[mid..-1])

  merge(left, right)
end

def merge(left, right)
  sorted = []
  i = j = 0

  while i < left.length && j < right.length
    if left[i] <= right[j]
      sorted << left[i]
      i += 1
    else
      sorted << right[j]
      j += 1
    end
  end

  sorted.concat(left[i..-1]) if i < left.length
  sorted.concat(right[j..-1]) if j < right.length

  sorted
end
arr = [38, 27, 43, 3, 9, 82, 10]
puts merge_sort(arr).inspect
