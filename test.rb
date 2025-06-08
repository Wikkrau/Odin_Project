word = "This is a test. This is only a test."
word.scan("is").each do |match|
  puts match
end