require_relative 'Board'
require_relative 'Player'
require_relative 'Constants'

class Game
  include Settings

  def initialize
    @board = Board.new
    @player1 = Player.new('Player 1', 'X')
    @player2 = Player.new('Player 2', 'O')
    @current_player = @player1
  end

  def play
    loop do
      @board.display_board
      puts "Player #{@current_player.symbol}'s turn. Choose column (1-#{Board_height}):"

      column = gets.chomp.to_i

      if valid_move?(column)
        @board.drop_piece(column - 1, @current_player) # Convert to 0-based index

        if @board.winning_combination?(@current_player)
          @board.display_board
          puts "Player #{@current_player.symbol} wins!"
          break
        elsif @board.full?
          @board.display_board
          puts "It's a tie!"
          break
        end

        switch_player
      else
        puts 'Invalid move! Try again.'
      end
    end
  end

  private

  def valid_move?(column)
    column.between?(1, Board_height) && !@board.grid[0][column - 1] # Check 1-based input, convert to 0-based
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
end
