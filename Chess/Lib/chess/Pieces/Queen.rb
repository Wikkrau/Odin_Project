require_relative 'Piece'

class Queen < Piece
  def possible_moves(board)
    moves = []
    row, col = @position
    directions = [
      [1, 0], [0, 1], [-1, 0], [0, -1],
      [1, 1], [1, -1], [-1, 1], [-1, -1]
    ]

    directions.each do |dx, dy|
      new_row = row
      new_col = col
      loop do
        new_row += dx
        new_col += dy
        break unless valid_position?(new_row, new_col)

        target_piece = board.piece_at([new_row, new_col])
        if target_piece.nil?
          moves << [new_row, new_col]
        elsif enemy?(target_piece)
          moves << [new_row, new_col]
          break
        else
          break
        end
      end
    end

    moves
  end
  # no need to add symbols since i have them in piece.rb from constants.rb
end
