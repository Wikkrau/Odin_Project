require_relative 'Piece'

class Pawn < Piece
  def possible_moves(board)
    moves = []
    row, col = @position
    direction = @color == 'white' ? 1 : -1

    # Forward move
    next_row = row + direction
    if valid_position?(next_row, col) && !board.piece_at([next_row, col])
      moves << [next_row, col]

      # Double move from starting position
      unless @has_moved
        double_move_row = next_row + direction
        if valid_position?(double_move_row, col) && !board.piece_at([double_move_row, col])
          moves << [double_move_row, col]
        end
      end
    end

    # Diagonal captures
    [-1, 1].each do |col_offset|
      capture_col = col + col_offset
      if valid_position?(next_row, capture_col)
        target_piece = board.piece_at([next_row, capture_col])
        moves << [next_row, capture_col] if enemy?(target_piece)
      end
    end

    moves
  end
end
