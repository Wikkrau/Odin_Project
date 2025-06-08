test_scores = [
  [97, 76, 79, 93],
  [79, 84, 76, 79],
  [88, 67, 64, 76],
  [94, 55, 67, 81]
]

teacher_mailboxes = [
  ["Adams", "Baker", "Clark", "Davis"],
  ["Jones", "Lewis", "Lopez", "Moore"],
  ["Perez", "Scott", "Smith", "Young"]
]

mutable_array = Array.new(3,Array.new(2))
mutable_array[1][0] = "A"
puts mutable_array.inspect
immutable_array = Array.new(3) {Array.new(2)}
immutable_array[0][0] = "A"
puts immutable_array.inspect

puts teacher_mailboxes.map {|number| teacher_mailboxes[number] + "" + test_scores[number].join(", ")}.join("\n")