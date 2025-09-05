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
    return false if other_piece.nil?  # Add this line

    @color != other_piece.color
  end

  def ally?(other_piece)
    return false if other_piece.nil?  # Add this line

    @color == other_piece.color
  end

  # Colored symbols for terminal display
  def symbol
    piece_char = PIECE_SYMBOLS[@color][self.class.name.downcase]

    if @color == 'white'
      "\e[97m#{piece_char}\e[0m"  # Bright white text
    else
      "\e[91m#{piece_char}\e[0m"  # Bright red text for black pieces
    end
  end

  def value
    PIECE_VALUES[self.class.name.downcase]
  end

  protected

  def valid_position?(row, col)
    row.between?(0, BOARD_SIZE - 1) && col.between?(0, BOARD_SIZE - 1)
  end
end
