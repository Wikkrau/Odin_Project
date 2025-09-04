require_relative 'Piece'

class King < Piece
  def possible_moves(board)
    moves = []
    row, col = @position

    directions = [
      [1, 0], [0, 1], [-1, 0], [0, -1],
      [1, 1], [1, -1], [-1, 1], [-1, -1]
    ]

    directions.each do |dx, dy|
      new_row = row + dx
      new_col = col + dy
      if valid_position?(new_row, new_col)
        target_piece = board.piece_at([new_row, new_col])
        moves << [new_row, new_col] if target_piece.nil? || enemy?(target_piece)
      end
    end

    moves
  end
  # no need to add symbols since i have them in piece.rb from constants.rb
end
