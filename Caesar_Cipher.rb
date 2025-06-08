$vocabulary = "abcdefghijklmnopqrstuvwxyz".split("")
$vocabulary_big = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("")

def caesar_cipher(word, shift)
  shift = shift.to_i % 26
  word.chars.map do |letter|
    if $vocabulary.include?(letter)
      index = $vocabulary.find_index(letter)
      $vocabulary[(index + shift) % 26]
    elsif $vocabulary_big.include?(letter)
      index = $vocabulary_big.find_index(letter)
      $vocabulary_big[(index + shift) % 26]
    else
      letter
    end
  end.join("")
end

puts caesar_cipher("What a string!", 5)