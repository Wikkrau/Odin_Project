# frozen_string_literal: true

shoes = {
  'summer' => 'sandals',
  'winter' => 'boots'
}

shoes['summer'] #=> "sandals"
shoes.fetch('hiking') #=> KeyError: key not found: "hiking"
shoes.fetch('hiking', 'hiking boots') #=> "hiking boots"

shoes['fall'] = 'sneakers'
shoes['summer'] = 'flip-flops'

shoes.delete('summer') #=> "flip-flops"

hash1 = { 'a' => 100, 'b' => 200 }
hash2 = { 'b' => 254, 'c' => 300 }
hash1.merge(hash2) #=> {"a"=>100, "b"=>254, "c"=>300}

american_cars = {
  chevrolet: 'Corvette',
  ford: 'Mustang',
  dodge: 'Ram'
}
# 'Symbols' syntax
japanese_cars = {
  honda: 'Accord',
  toyota: 'Corolla',
  nissan: 'Altima'
}

american_cars[:ford]    #=> "Mustang"
japanese_cars[:honda]   #=> "Accord"
