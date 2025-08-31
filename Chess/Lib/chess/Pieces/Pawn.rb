require_relative 'Piece'

class Pawn < Piece
  def possible_moves(board)
    moves = []
    row, col = @position
    direction = @color == 'white' ? 1 : -1

    # Forward moves
    next_row = row + direction
    if valid_position?(next_row, col) && !board.piece_at([next_row, col])
      moves << [next_row, col]

      # Double move from starting position
      unless @has_moved
        next_next_row = next_row + direction
        moves << [next_next_row, col] if valid_position?(next_next_row, col) && !board.piece_at([next_next_row, col])
      end
    end

    # Diagonal captures
    [-1, 1].each do |col_offset|
      new_col = col + col_offset
      if valid_position?(next_row, new_col)
        target_piece = board.piece_at([next_row, new_col])
        moves << [next_row, new_col] if enemy?(target_piece)
      end
    end

    moves
  end

  def symbol
    @color == 'white' ? '♙' : '♟'
  end
end
