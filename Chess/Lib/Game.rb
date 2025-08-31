require_relative 'Board'
require_relative 'player'
require_relative 'Constants'
require_relative 'SaveLoad'
require_relative 'MoveValidator'

class Game
  include ChessSettings
  include SaveLoad

  def initialize
    @board = Board.new
    @player1 = Player.new('Player 1', 'white')
    @player2 = Player.new('Player 2', 'black')
    @current_player = @player1
    @move_history = []
    @game_over = false
  end

  def play
    display_rules

    until @game_over
      @board.display
      handle_turn
      check_game_end
      switch_player unless @game_over
    end
  end

  private

  def handle_turn
    puts "#{@current_player.name}'s turn (#{@current_player.color})"
    puts "Enter move (e.g., 'e2 e4') or 'save'/'load'/'quit':"

    input = gets.chomp.downcase

    case input
    when 'save' then save_game
    when 'load' then load_game
    when 'quit' then @game_over = true
    else
      process_move(input)
    end
  end

  def process_move(input)
    # Parse input like "e2 e4" and convert to array coordinates
    # Implementation here...
  end
end
