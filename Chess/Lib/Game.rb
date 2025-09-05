require_relative 'Board'
require_relative 'player'
require_relative 'constants'
require_relative 'CheckSystem'
require_relative 'DisplayHelpers'

class Game
  include ChessSettings
  include CheckSystem
  include DisplayHelpers

  attr_reader :board, :current_player, :game_over

  def initialize
    @board = Board.new
    @player1 = Player.new('Player 1', 'white')
    @player2 = Player.new('Player 2', 'black')
    @current_player = @player1
    @game_over = false
    @selected_piece = nil
    @selected_position = nil
  end

  def play
    tutorial_notes

    until @game_over
      display_game_state
      handle_user_input
    end
  end

  # API METHOD: Process move for web interface (commented out for now)
  # def process_move(from_notation, to_notation)
  #   from_pos = notation_to_position(from_notation)
  #   to_pos = notation_to_position(to_notation)
  #
  #   return { success: false, error: "Invalid notation" } unless from_pos && to_pos
  #
  #   piece = @board.piece_at(from_pos)
  #   return { success: false, error: "No piece at #{from_notation}" } unless piece
  #   return { success: false, error: "Not your piece" } unless piece.color == @current_player.color
  #
  #   if execute_move(from_pos, to_pos)
  #     switch_players
  #     check_game_end
  #     { success: true, game_over: @game_over, board: @board.to_json }
  #   else
  #     { success: false, error: "Invalid move" }
  #   end
  # end

  private

  # ========== GAME FLOW METHODS ==========

  def tutorial_notes
    puts 'Welcome to Chess!'
    puts "Select a piece position (e.g., 'e2'), then destination (e.g., 'e4')"
    puts "Commands: 'cancel', 'quit', 'restart', 'save', 'load'"
    puts 'Beginning game in 5 seconds...'
    sleep(5)
  end

  def controls
    puts 'Controls:'
    # puts "Select a piece: Click on the piece you want to move"
    # puts "Move a piece: Click on the destination square"
    puts "Select a piece position (e.g., 'e2'), then destination (e.g., 'e4')"
    puts "Commands: 'cancel', 'quit', 'restart', 'save', 'load'"
  end

  def display_game_state
    clear_screen
    controls
    @board.display
    show_check_status
    show_selection_status
  end

  def handle_user_input
    input = gets.chomp.downcase

    case input
    when 'quit' then quit_game
    when 'restart' then restart_game
    when 'cancel' then cancel_selection
    when 'save' then save_game
    when 'load' then load_game
    when /\A[a-h][1-8]\z/ then handle_position_input(input)
    else show_invalid_input_message
    end
  end

  # ========== PIECE SELECTION METHODS ==========

  def handle_position_input(position)
    if @selected_piece.nil?
      select_piece(position)
    else
      move_to_destination(position)
    end
  end

  def select_piece(position)
    pos = notation_to_position(position)
    piece = @board.piece_at(pos)

    # Validation checks
    return show_error("No piece at #{position}") unless piece
    return show_error("That's not your piece!") unless piece.color == @current_player.color

    # Get legal moves
    legal_moves = get_legal_moves_for_piece(piece, pos)
    return show_error('That piece has no legal moves!') if legal_moves.empty?

    # Select piece
    @selected_piece = piece
    @selected_position = pos
    show_piece_selected(piece, position, legal_moves)
  end

  def move_to_destination(destination)
    to_pos = notation_to_position(destination)

    if execute_move(@selected_position, to_pos)
      show_successful_move(destination)
      cancel_selection
      switch_players
      check_game_end
    else
      show_error("Invalid move! Try another destination or 'cancel'")
    end
  end

  # ========== MOVE EXECUTION METHODS ==========

  def execute_move(from_pos, to_pos)
    piece = @board.piece_at(from_pos)

    # Validate move
    return false unless valid_move?(piece, from_pos, to_pos)
    return false if king_in_check?(@current_player.color) && !move_escapes_check?(from_pos, to_pos)

    # Execute move
    captured_piece = @board.piece_at(to_pos)
    @board.move_piece(from_pos, to_pos)

    # Check for king capture (immediate win)
    if captured_piece&.class&.name&.downcase == 'king'
      end_game_by_capture(captured_piece.color)
      return true
    end

    show_capture_message(captured_piece) if captured_piece
    true
  end

  def valid_move?(piece, from_pos, to_pos)
    piece.possible_moves(@board).include?(to_pos)
  end

  def get_legal_moves_for_piece(piece, from_pos)
    if king_in_check?(@current_player.color)
      get_moves_that_escape_check(piece, from_pos)
    else
      piece.possible_moves(@board)
    end
  end

  # ========== GAME STATE METHODS ==========

  def switch_players
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def check_game_end
    return if @game_over

    if checkmate?(@current_player.color)
      end_game_by_checkmate
    elsif stalemate?(@current_player.color)
      end_game_by_stalemate
    end
  end

  def end_game_by_capture(captured_king_color)
    show_game_end_message(captured_king_color, 'capture')
    @game_over = true
  end

  def end_game_by_checkmate
    show_game_end_message(nil, 'checkmate')
    @game_over = true
  end

  def end_game_by_stalemate
    show_game_end_message(nil, 'stalemate')
    @game_over = true
  end

  # ========== UTILITY METHODS ==========

  def notation_to_position(notation)
    return nil unless notation.match?(/\A[a-h][1-8]\z/)

    col = notation[0].ord - 'a'.ord
    row = notation[1].to_i - 1
    [row, col]
  end

  def position_to_notation(position)
    row, col = position
    "#{(col + 'a'.ord).chr}#{row + 1}"
  end

  def cancel_selection
    return unless @selected_piece

    puts 'Selection cancelled'
    @selected_piece = nil
    @selected_position = nil
  end

  def restart_game
    @board = Board.new
    @current_player = @player1
    @game_over = false
    cancel_selection
    puts 'Game restarted!'
    sleep(1)
  end

  def quit_game
    @game_over = true
    puts 'Thanks for playing!'
  end

  def save_game
    puts 'Save feature not implemented yet'
    sleep(1)
  end

  def load_game
    puts 'Load feature not implemented yet'
    sleep(1)
  end

  # ========== DISPLAY HELPER METHODS ==========

  def show_error(message)
    puts message
    sleep(1)
  end

  def show_piece_selected(piece, position, legal_moves)
    puts "Selected #{piece.class.name.downcase} at #{position}. Choose destination or 'cancel'"
    puts "Legal moves: #{legal_moves.map { |move| position_to_notation(move) }.join(', ')}"
  end

  def show_successful_move(destination)
    from_notation = position_to_notation(@selected_position)
    show_move_message(@selected_piece.class.name.downcase, from_notation, destination)
    sleep(1.5)
  end

  def show_invalid_input_message
    puts "Invalid input. Use chess notation (e.g., 'e2') or commands"
    sleep(1)
  end

  def show_selection_status
    if @selected_piece
      pos_notation = position_to_notation(@selected_position)
      puts "#{@current_player.name}'s turn (#{@current_player.color}) - #{@selected_piece.class.name.downcase} selected at #{pos_notation}"
    else
      puts "#{@current_player.name}'s turn (#{@current_player.color}) - Select a piece"
    end
  end

  # ========== Add this method to your existing private methods ==========

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
    # Simulate the move on a copy of the board
    temp_board = @board.deep_copy
    temp_board.move_piece(from_pos, to_pos)

    # Check if king is still in check after the move
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
