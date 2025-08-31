require_relative 'Board'
require_relative 'player'
require_relative 'constants'

class Game
  include ChessSettings

  def initialize
    @board = Board.new
    @player1 = Player.new('Player 1', 'white')
    @player2 = Player.new('Player 2', 'black')
    @current_player = @player1
    @game_over = false
  end

  def play
    puts 'Welcome to Chess!'
    puts "Enter moves like 'e2 e4' or type 'quit' to exit"

    until @game_over
      @board.display
      puts "#{@current_player.name}'s turn (#{@current_player.color})"

      input = gets.chomp.downcase
      case input
      when 'quit'
        @game_over = true
        puts 'Thanks for playing!'
      else
        puts 'Move processing not implemented yet'
        # TODO: implement move processing
      end
    end
  end
end
