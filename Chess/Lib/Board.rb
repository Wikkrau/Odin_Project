require_relative 'Constants'
require_relative 'chess/Pieces/Piece'
require_relative 'chess/Pieces/Pawn'
require_relative 'chess/Pieces/Rook'
require_relative 'chess/Pieces/Knight'
require_relative 'chess/Pieces/Bishop'
require_relative 'chess/Pieces/Queen'
require_relative 'chess/Pieces/King'

class Board
  include ChessSettings

  attr_reader :grid

  def initialize
    @grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, nil) }
    setup_pieces
  end

  def piece_at(position)
    row, col = position
    return nil unless valid_position?(row, col)

    @grid[row][col]
  end

  def move_piece(from, to)
    piece = piece_at(from)
    return false unless piece

    @grid[to[0]][to[1]] = piece
    @grid[from[0]][from[1]] = nil
    piece.move_to(to)
    true
  end

  def display
    puts '  a b c d e f g h'
    (BOARD_SIZE - 1).downto(0) do |row|
      print "#{row + 1} "
      (0...BOARD_SIZE).each do |col|
        piece = @grid[row][col]
        print piece ? piece.symbol : '·'
        print ' '
      end
      puts " #{row + 1}"
    end
    puts '  a b c d e f g h'
  end

  # Clear all pieces from board (for loading saved games)
  def clear_board
    @grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, nil) }
  end

  # Place a piece at specific position (for loading saved games)
  def place_piece(piece, position)
    row, col = position
    @grid[row][col] = piece
    piece.position = position
  end

  # Find specific piece type on board
  def find_piece(color, piece_type)
    @grid.flatten.compact.find do |piece|
      piece.color == color && piece.class.name.downcase == piece_type
    end
  end

  # Get all pieces of a specific color
  def pieces_by_color(color)
    @grid.flatten.compact.select { |piece| piece.color == color }
  end

  # Check if position is under attack by enemy pieces
  def position_under_attack?(position, attacking_color)
    pieces_by_color(attacking_color).any? do |piece|
      piece.possible_moves(self).include?(position)
    end
  end

  # Create deep copy of board (for move validation without affecting real board)
  def deep_copy
    new_board = Board.new
    new_board.clear_board

    @grid.each_with_index do |row, row_index|
      row.each_with_index do |piece, col_index|
        next unless piece

        new_piece = piece.class.new(piece.color, [row_index, col_index])
        new_piece.instance_variable_set(:@has_moved, piece.has_moved)
        new_board.place_piece(new_piece, [row_index, col_index])
      end
    end

    new_board
  end

  private

  def setup_pieces
    STARTING_POSITIONS.each do |color, pieces|
      pieces.each do |piece_type, positions|
        positions.each do |pos|
          piece = create_piece(piece_type, color, pos)
          @grid[pos[0]][pos[1]] = piece
        end
      end
    end
  end

  def create_piece(type, color, position)
    case type
    when 'pawn' then Pawn.new(color, position)
    when 'rook' then Rook.new(color, position)
    when 'knight' then Knight.new(color, position)
    when 'bishop' then Bishop.new(color, position)
    when 'queen' then Queen.new(color, position)
    when 'king' then King.new(color, position)
    end
  end

  def valid_position?(row, col)
    row.between?(0, BOARD_SIZE - 1) && col.between?(0, BOARD_SIZE - 1)
  end
end
