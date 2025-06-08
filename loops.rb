i = 0
# loop do 
#     puts "This is loop number #{i}"
#     i += 1
#     break if i == 10
# end


# i = 0
# while i < 10 do
#     puts "This is loop number #{i}"
#     i += 1
# end


# while gets.chomp != "yes" do
#     puts "are we there yet?"
# end

# i= 0
# until i >= 10 do
#     puts "This is loop number #{i}"
#     i += 1
# end
# puts "____________________"
# i = 1
# for i in 1..5 do
#     puts "This is for loop number #{i}"
# end

# for i in 'a'..'f' do
#     puts "This is for loop number #{i}"
# end
# puts "Test 1"
# 5.times do  
#     puts "This is times loop number #{i}"  
# end
# puts "Test 2"
# 5.times do |i|
#     puts "This is times loop number #{i}"
# end

5.upto(10) do |i|
    puts "This is upto loop number #{i}"
      
end
10.downto(5) do |i|
    puts "This is downto loop number #{i}"
end