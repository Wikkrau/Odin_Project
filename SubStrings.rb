dictionary = %w[below down go going horn how howdy it i low own part partner sit]

def substrings(text, dictionary)
  result = Hash.new(0)

  dictionary.each do |word|
    text.downcase.scan(word).each do |_match|
      result[word] += 1
    end
  end
  result
end

puts substrings("Howdy partner, sit down! How's it going", dictionary)
