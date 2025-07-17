# non recursive
def walk(steps)
  while steps > 0
    puts "Walking #{steps} steps"
    steps -= 1
  end
  puts 'No more steps to walk.'
end

# walk(100)
# recursive
def walkr(steps)
  if steps <= 0
    puts 'No more steps to walk.'
  else
    # puts "Walking #{steps} steps" from 100 to 1 its like a stack
    # we can print it after the recursive call
    # so it will print from 1 to 100
    # this is the recursive call
    walkr(steps - 1)
    puts "Walking #{steps} steps"

  end
end
# walk(100)
walkr(100)
