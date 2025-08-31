require_relative '../../constants'

class Piece
  include ChessSettings

  attr_reader :color, :has_moved
  attr_accessor :position

  def initialize(color, position)
    @color = color
    @position = position
    @has_moved = false
  end

  # Each piece must implement this method (abstract method)
  def possible_moves(board)
    raise NotImplementedError, "#{self.class} must implement possible_moves method"
  end

  # Common methods all pieces can use
  def move_to(new_position)
    @position = new_position
    @has_moved = true
  end

  def enemy?(other_piece)
    other_piece && other_piece.color != @color
  end

  def ally?(other_piece)
    other_piece && other_piece.color == @color
  end

  def symbol
    PIECE_SYMBOLS[@color][self.class.name.downcase]
  end

  def value
    PIECE_VALUES[self.class.name.downcase]
  end

  protected

  # Only this class and subclasses can use this method
  def valid_position?(row, col)
    row.between?(0, BOARD_SIZE - 1) && col.between?(0, BOARD_SIZE - 1)
  end
end
