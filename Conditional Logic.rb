if 1 < 2
  puts '1 is less than 2'
else
  puts 'fucking dumb'
end

if attack_by_land == true
  puts 'release the goat'
elsif attack_by_sea == true
  puts 'release the shark'
else
  puts 'release Kevin the octopus'
end

5 == 5 ? puts('5 is equal to 5') : puts('5 is not equal to 5')
5 > 6 ? puts('5 is greater than 6') : puts('5 is not greater than 6')
5.eql?(5) ? puts('5 is equal to 5') : puts('5 is not equal to 5')

a = 5
b = 6
a.eql?(b) ? puts('5 is equal to 6') : puts('5 is not equal to 6')

5 <=> 10    #=> -1
10 <=> 10   #=> 0
10 <=> 5    #=> 1

puts "Party at Kevin's!" if 1 < 2 && 5 < 6

# This can also be written as
puts "Party at Kevin's!" if 1 < 2 and 5 < 6

grade = 'F'
case grade
when 'A'
  puts 'Excellent!'
when 'B'
  puts 'Good job!'
when 'C'
  puts 'Well done!'
when 'D'
  puts 'You passed.'
when 'F'
  puts 'Better try again.'
else
  puts 'Invalid grade.'
end
# This can also be written as
Resoult = case grade
          when 'A'
            'Excellent!'
          when 'B'
            'Good job!'
          when 'C'
            'Well done!'
          when 'D'
            'You passed.'
          when 'F'
            'Better try again.'
          else
            'Invalid grade.'
          end
