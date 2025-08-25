require_relative 'Player'
require_relative 'Constants'

class Board
  attr_accessor :grid

  include Settings
  def initialize
    @grid = Array.new(Board_width) { Array.new(Board_height, nil) }
  end

  def drop_piece(column, player)
    row = @grid.rindex { |r| r[column].nil? }
    @grid[row][column] = player.symbol if row
  end

  def full?
    @grid.all? { |row| row.all? }
  end

  def display_board
    @grid.each do |row|
      puts row.map { |cell| cell.nil? ? '.' : cell }.join(' ')
    end
  end

  def check_horizontal(symbol)
    @grid.each do |row|
      return true if row.join.include?(symbol * WINNING_LENGTH)
    end
    false
  end

  def check_vertical(symbol)
    (0...Board_height).each do |col|
      column = @grid.map { |row| row[col] }
      return true if column.join.include?(symbol * WINNING_LENGTH)
    end
    false
  end

  def check_diagonal(symbol)
    @grid.each_with_index do |row, r|
      row.each_with_index do |cell, c|
        next if cell != symbol

        # Check diagonal going down-right (\)
        return true if diagonal_down_right_win?(r, c, symbol)

        # Check diagonal going down-left (/)
        return true if diagonal_down_left_win?(r, c, symbol)
      end
    end
    false
  end

  def winning_combination?(player)
    symbol = player.symbol
    check_horizontal(symbol) || check_vertical(symbol) || check_diagonal(symbol)
  end

  private

  def diagonal_down_right_win?(row, col, symbol)
    return false if row + WINNING_LENGTH > Board_width
    return false if col + WINNING_LENGTH > Board_height

    (0...WINNING_LENGTH).all? do |i|
      @grid[row + i][col + i] == symbol
    end
  end

  def diagonal_down_left_win?(row, col, symbol)
    return false if row + WINNING_LENGTH > Board_width
    return false if col - WINNING_LENGTH + 1 < 0

    (0...WINNING_LENGTH).all? do |i|
      @grid[row + i][col - i] == symbol
    end
  end
end
