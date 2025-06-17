require_relative 'game'

puts 'Welcome to Tic-Tac-Toe!'

answer = ''

confirmation_answers = ['yes', 'sure', 'yeah', 'alright', 'y', 'ye', 'ok', 'okay',
                        'sounds good', 'aight','bet']

until confirmation_answers.include?(answer.downcase)
  print 'Are you ready to play?: '
  answer = gets.to_s.chomp
end
game = Game.new
game.start
