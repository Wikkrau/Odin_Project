def iterative_fibonacci(quantity)
  return [] if quantity <= 0
  return [0] if quantity == 1
  return [0, 1] if quantity == 2

  sequence = [0, 1]

  (3..quantity).each do
    next_number = sequence[-1] + sequence[-2]
    sequence << next_number
  end

  sequence
end
iterative_fibonacci(10).each { |num| puts num }

def Fibonachi(n)
  if n <= 2
    1
  else
    Fibonachi(n - 1) + Fibonachi(n - 2)
  end
end
puts Fibonachi(9)
