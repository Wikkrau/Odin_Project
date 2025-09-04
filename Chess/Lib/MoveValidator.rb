class MoveValidator
  def self.valid_move?(board, from, to, current_player)
    piece = board.piece_at(from)
    return false unless piece
    return false unless piece.color == current_player
    return false unless piece.possible_moves(board).include?(to)
    return false if would_be_in_check?(board, from, to, current_player)

    true
  end

  def self.in_check?(board, color)
    king_position = find_king(board, color)
    enemy_color = color == 'white' ? 'black' : 'white'

    board.grid.flatten.compact.each do |piece|
      next unless piece.color == enemy_color
      return true if piece.possible_moves(board).include?(king_position)
    end

    false
  end

  # Check if move would leave own king in check
  def self.would_be_in_check?(board, from, to, player_color)
    # Create copy of board and try the move
    test_board = board.deep_copy
    test_board.move_piece(from, to)

    # Check if king would be in check after this move
    in_check?(test_board, player_color)
  end

  # Find king position on board
  def self.find_king(board, color)
    king = board.find_piece(color, 'king')
    king ? king.position : nil
  end

  # Check for checkmate (king in check with no legal moves)
  def self.checkmate?(board, color)
    return false unless in_check?(board, color)

    # Try all possible moves for this color
    board.pieces_by_color(color).each do |piece|
      piece.possible_moves(board).each do |move|
        return false unless would_be_in_check?(board, piece.position, move, color)
      end
    end

    true # No moves can get out of check = checkmate
  end

  # Check for stalemate (not in check but no legal moves)
  def self.stalemate?(board, color)
    return false if in_check?(board, color)

    # Check if any legal moves exist
    board.pieces_by_color(color).each do |piece|
      piece.possible_moves(board).each do |move|
        return false unless would_be_in_check?(board, piece.position, move, color)
      end
    end

    true # No legal moves but not in check = stalemate
  end
end
