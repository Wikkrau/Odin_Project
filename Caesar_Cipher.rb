$vocabulary = "abcdefghijklmnopqrstuvwxyz".split("")

def caesar_cipher(word, shift)
  shift = shift.to_i % 26
  word.downcase.chars.map do |letter|
    if $vocabulary.include?(letter)
      index = $vocabulary.find_index(letter)
      $vocabulary[(index + shift) % 26]
    else
      letter
    end
  end.join("").capitalize
end

puts caesar_cipher("What a string!", 5)
