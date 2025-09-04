module CheckSystem
  def king_in_check?(color)
    king = find_king(color)
    return false unless king

    enemy_color = color == 'white' ? 'black' : 'white'

    @board.grid.flatten.compact.each do |piece|
      next unless piece.color == enemy_color
      return true if piece.possible_moves(@board).include?(king.position)
    end

    false
  end

  def checkmate?(color)
    king_in_check?(color) && no_moves_escape_check?(color)
  end

  def stalemate?(color)
    !king_in_check?(color) && no_legal_moves?(color)
  end

  def find_king(color)
    @board.grid.flatten.compact.find do |piece|
      piece.color == color && piece.class.name.downcase == 'king'
    end
  end

  def no_legal_moves?(color)
    @board.grid.flatten.compact.each do |piece|
      next unless piece.color == color
      return false unless piece.possible_moves(@board).empty?
    end
    true
  end

  def no_moves_escape_check?(color)
    @board.grid.flatten.compact.each do |piece|
      next unless piece.color == color

      piece.possible_moves(@board).each do |move|
        return false if move_escapes_check?(piece.position, move)
      end
    end
    true
  end

  def move_escapes_check?(from_pos, to_pos)
    temp_board = @board.deep_copy
    temp_board.move_piece(from_pos, to_pos)
    !king_would_be_in_check_on_board?(temp_board, @current_player.color)
  end

  def king_would_be_in_check_on_board?(board, color)
    king = board.grid.flatten.compact.find do |piece|
      piece.color == color && piece.class.name.downcase == 'king'
    end
    return false unless king

    enemy_color = color == 'white' ? 'black' : 'white'

    board.grid.flatten.compact.each do |piece|
      next unless piece.color == enemy_color
      return true if piece.possible_moves(board).include?(king.position)
    end

    false
  end

  def get_moves_that_escape_check(piece, from_pos)
    moves = []
    piece.possible_moves(@board).each do |to_pos|
      moves << to_pos if move_escapes_check?(from_pos, to_pos)
    end
    moves
  end
end
