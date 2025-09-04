require 'json'

module SaveLoad
  def save_game(filename = 'chess_save.json')
    # Hash makes it easy to convert to JSON format for file storage
    game_state = {
      board: serialize_board, # Convert board to saveable format
      current_player: @current_player.color, # Just save the color string
      move_history: @move_history,      # Array of moves made
      castling_rights: @castling_rights # Track if castling is still legal
    }

    # Convert hash to JSON string and save to file
    File.write(filename, JSON.pretty_generate(game_state))
    puts "Game saved to #{filename}"
  end

  def load_game(filename = 'chess_save.json')
    return false unless File.exist?(filename)

    # Load JSON and convert back to hash
    game_state = JSON.parse(File.read(filename))
    restore_game_state(game_state)
    puts "Game loaded from #{filename}"
    true
  end

  private

  # Convert board object to simple array format for saving
  def serialize_board
    serialized = []
    @board.grid.each_with_index do |row, row_index|
      row.each_with_index do |piece, col_index|
        next unless piece

        serialized << {
          type: piece.class.name.downcase,
          color: piece.color,
          position: [row_index, col_index],
          has_moved: piece.has_moved
        }
      end
    end
    serialized
  end

  # Rebuild board from saved data
  def restore_game_state(game_state)
    @board = Board.new
    @board.clear_board # Remove starting pieces

    # Recreate pieces from saved data
    game_state['board'].each do |piece_data|
      piece = create_piece_from_data(piece_data)
      @board.place_piece(piece, piece_data['position'])
    end

    # Restore other game state
    @current_player = game_state['current_player'] == 'white' ? @player1 : @player2
    @move_history = game_state['move_history'] || []
    @castling_rights = game_state['castling_rights'] || default_castling_rights
  end

  # Helper to recreate piece objects from saved data
  def create_piece_from_data(data)
    case data['type']
    when 'pawn' then Pawn.new(data['color'], data['position'])
    when 'rook' then Rook.new(data['color'], data['position'])
    when 'knight' then Knight.new(data['color'], data['position'])
    when 'bishop' then Bishop.new(data['color'], data['position'])
    when 'queen' then Queen.new(data['color'], data['position'])
    when 'king' then King.new(data['color'], data['position'])
    end.tap do |piece|
      piece.instance_variable_set(:@has_moved, data['has_moved'])
    end
  end

  # Default castling rights (both sides can castle initially)
  def default_castling_rights
    {
      'white' => { 'kingside' => true, 'queenside' => true },
      'black' => { 'kingside' => true, 'queenside' => true }
    }
  end
end
