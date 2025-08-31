require_relative 'constants'
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
    puts "\n  a b c d e f g h"
    (BOARD_SIZE - 1).downto(0) do |row|
      print "#{row + 1} "
      (0...BOARD_SIZE).each do |col|
        piece = @grid[row][col]
        print piece ? piece.symbol : '·'
        print ' '
      end
      puts " #{row + 1}"
    end
    puts "  a b c d e f g h\n"
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
