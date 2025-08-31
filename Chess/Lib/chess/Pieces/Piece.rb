require_relative '../Constants'

class Piece
  include ChessSettings

  attr_reader :color, :position, :has_moved
  attr_accessor :position

  def initialize(color, position)
    @color = color
    @position = position
    @has_moved = false
  end

  # Abstract method - each piece implements its own moves
  def possible_moves(board)
    raise NotImplementedError, 'Subclass must implement possible_moves'
  end

  # Common methods all pieces share
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
    raise NotImplementedError, 'Subclass must implement symbol'
  end

  def value
    PIECE_VALUES[self.class.name.downcase]
  end

  protected

  def valid_position?(row, col)
    row.between?(0, BOARD_SIZE - 1) && col.between?(0, BOARD_SIZE - 1)
  end
end
