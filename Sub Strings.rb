dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(word,dictionary)
  result = Hash.new(0)
  
  dictionary.each do |dic_word|
    word.scan(dic_word).each do |match|
      result[dic_word] += 1
    end
  end
  return result
end

puts substrings("below", dictionary)

