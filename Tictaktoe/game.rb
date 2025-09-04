# frozen_string_literal: true

require_relative 'Board'
require_relative 'Player'

class Game
  attr_reader :player1, :player2, :board

  def initialize
    print 'Player 1, please enter name: '
    name1 = gets.chomp
    @player1 = Player.new(name1, 'X')

    print 'Player 2, please enter name: '
    name2 = gets.chomp
    @player2 = Player.new(name2, 'O')

    @current_player = @player1
    @board = Board.new
    @board.display
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def take_turn
    loop do
      puts "#{@current_player.name}, take your turn. Your marker is #{@current_player.tag}.  Enter column and row (1-3), e.g., '1 2'"
      input = gets.chomp.split.map(&:to_i)
      if input.length != 2
        puts 'Invalid input. Please provide two numbers with space.'
        next
      end

      row, col = input.map { |i| i - 1 }

      if row.between?(0, 2) && col.between?(0, 2)
        if @board.grid[row][col] == ' '
          @board.grid[row][col] = @current_player.tag
          return true
        else
          puts 'Spot already taken.'
        end
      else
        puts 'Invalid position. Use numbers from 1 to 3.'
      end
    end
  end

  def check_winner
    grid = @board.grid

    # Rows
    grid.each do |row|
      return @current_player.name if row.all? { |cell| cell == row[0] && cell != ' ' }
    end

    # Columns
    (0..2).each do |col|
      return @current_player.name if grid[0][col] == grid[1][col] && grid[1][col] == grid[2][col] && grid[0][col] != ' '
    end

    # Diagonals
    return @current_player.name if grid[0][0] == grid[1][1] && grid[1][1] == grid[2][2] && grid[0][0] != ' '

    return @current_player.name if grid[0][2] == grid[1][1] && grid[1][1] == grid[2][0] && grid[0][2] != ' '

    # Draw
    return 'draw' if grid.flatten.none? { |cell| cell == ' ' }

    nil
  end

  def start
    loop do
      puts `clear`
      @board.display
      take_turn
      result = check_winner
      if result
        @board.display
        puts result == 'draw' ? "It's a draw!" : "#{result} wins!"
        break
      end
      switch_player
    end
  end
end
