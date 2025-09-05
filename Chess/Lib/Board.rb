require_relative 'constants'
<<<<<<< HEAD
require_relative 'pieces_loader'
=======
require_relative 'chess/Pieces/Piece'
require_relative 'chess/Pieces/Pawn'
require_relative 'chess/Pieces/Rook'
require_relative 'chess/Pieces/Knight'
require_relative 'chess/Pieces/Bishop'
require_relative 'chess/Pieces/Queen'
require_relative 'chess/Pieces/King'
>>>>>>> 4f8d67cc21064a469b2fb7e363ee3a2481edb632

class Board
  include ChessSettings

  attr_reader :grid

  def initialize
<<<<<<< HEAD
    @grid = create_empty_grid
    setup_starting_pieces
  end

  # Get piece at specific position
=======
    @grid = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, nil) }
    setup_pieces
  end

>>>>>>> 4f8d67cc21064a469b2fb7e363ee3a2481edb632
  def piece_at(position)
    row, col = position
    return nil unless valid_position?(row, col)

    @grid[row][col]
  end

<<<<<<< HEAD
  # Move piece from one position to another
  def move_piece(from_pos, to_pos)
    piece = piece_at(from_pos)
    return false unless piece
    return false unless valid_position?(to_pos[0], to_pos[1])

    # Clear old position
    @grid[from_pos[0]][from_pos[1]] = nil

    # Place piece at new position
    @grid[to_pos[0]][to_pos[1]] = piece
    piece.move_to(to_pos)

    true
  end

  # Display board in terminal
=======
  def move_piece(from, to)
    piece = piece_at(from)
    return false unless piece

    @grid[to[0]][to[1]] = piece
    @grid[from[0]][from[1]] = nil
    piece.move_to(to)
    true
  end

>>>>>>> 4f8d67cc21064a469b2fb7e363ee3a2481edb632
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

<<<<<<< HEAD
  # Create deep copy for move simulation
  def deep_copy
    new_board = Board.new
    new_board.clear_board

    @grid.each_with_index do |row, row_index|
      row.each_with_index do |piece, col_index|
        if piece
          new_piece = create_piece_copy(piece)
          new_board.place_piece(new_piece, [row_index, col_index])
        end
      end
    end

    new_board
  end

  # Clear all pieces (used for loading games)
  def clear_board
    @grid = create_empty_grid
  end

  # Place piece at position (used for setup/loading)
  def place_piece(piece, position)
    row, col = position
    @grid[row][col] = piece
    piece.position = position if piece.respond_to?(:position=)
  end

  # later for web interface !!!
  # Convert board to JSON for web interface
  # def to_json(*_args)
  #   board_data = []
  #   @grid.each_with_index do |row, row_index|
  #     row.each_with_index do |piece, col_index|
  #       next unless piece

  #       board_data << {
  #         type: piece.class.name.downcase,
  #         color: piece.color,
  #         position: [row_index, col_index],
  #         symbol: piece.symbol
  #       }
  #     end
  #   end
  #   board_data.to_json
  # end

  private

  def create_empty_grid
    Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE, nil) }
  end

  def setup_starting_pieces
=======
  private

  def setup_pieces
>>>>>>> 4f8d67cc21064a469b2fb7e363ee3a2481edb632
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

<<<<<<< HEAD
  def create_piece_copy(original)
    new_piece = create_piece(
      original.class.name.downcase,
      original.color,
      original.position.dup
    )
    # Copy the has_moved state
    new_piece.instance_variable_set(:@has_moved, original.has_moved) if original.respond_to?(:has_moved)
    new_piece
  end

=======
>>>>>>> 4f8d67cc21064a469b2fb7e363ee3a2481edb632
  def valid_position?(row, col)
    row.between?(0, BOARD_SIZE - 1) && col.between?(0, BOARD_SIZE - 1)
  end
end
