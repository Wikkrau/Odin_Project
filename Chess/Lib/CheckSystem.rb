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
    return false unless king_in_check?(color)

    @board.grid.flatten.compact.each do |piece|
      next unless piece.color == color

      piece.possible_moves(@board).each do |move|
        # Save original state
        original_piece = @board.piece_at(move)
        original_position = piece.position.dup

        # Make the move
        @board.grid[piece.position[0]][piece.position[1]] = nil
        @board.grid[move[0]][move[1]] = piece
        piece.instance_variable_set(:@position, move)

        # Check if still in check
        still_in_check = king_in_check?(color)

        # Restore state
        @board.grid[move[0]][move[1]] = original_piece
        @board.grid[original_position[0]][original_position[1]] = piece
        piece.instance_variable_set(:@position, original_position)

        return false unless still_in_check
      end
    end

    true
  end

  def stalemate?(color)
    return false if king_in_check?(color)

    # Check if any piece has legal moves
    @board.grid.flatten.compact.each do |piece|
      next unless piece.color == color

      piece.possible_moves(@board).each do |move|
        # Simulate the move
        original_piece = @board.piece_at(move)
        @board.move_piece(piece.position, move)

        # Check if this puts own king in check
        puts_self_in_check = king_in_check?(color)

        # Restore board state
        @board.move_piece(move, piece.position)
        @board.place_piece(original_piece, move) if original_piece

        return false unless puts_self_in_check
      end
    end

    true
  end

  private

  def find_king(color)
    @board.grid.flatten.compact.find do |piece|
      piece.color == color && piece.class.name.downcase == 'king'
    end
  end

  def no_legal_moves?(color)
    @board.grid.flatten.compact.each do |piece|
      next unless piece.color == color

      piece.possible_moves(@board).each do |move|
        return false if move_escapes_check?(piece.position, move)
      end
    end
    true
  end

  def move_escapes_check?(from_pos, to_pos)
    # Create temporary board state
    temp_board = @board.deep_copy
    temp_board.move_piece(from_pos, to_pos)

    # Check if king would still be in check
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
end
