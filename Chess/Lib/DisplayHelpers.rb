module DisplayHelpers
  def clear_screen
    system('clear') || system('cls')
  end

  def show_check_status
    if king_in_check?(@current_player.color)
      puts "🚨 #{@current_player.color.upcase} KING IS IN CHECK! 🚨"
      puts 'You MUST move your king to safety or block the attack!'
    end

    enemy_color = @current_player.color == 'white' ? 'black' : 'white'
    return unless king_in_check?(enemy_color)

    puts "⚠️  #{enemy_color.upcase} king is in check!"
  end

  def show_capture_message(captured_piece)
    return unless captured_piece

    puts "Captured #{captured_piece.class.name.downcase}!"
  end

  def show_move_message(piece_name, from_notation, destination)
    puts "Moved #{piece_name} from #{from_notation} to #{destination}"
  end

  def show_game_end_message(winner = nil, type = 'capture')
    case type
    when 'capture'
      puts "#{winner.upcase} KING CAPTURED!"
      puts "#{@current_player.name} (#{@current_player.color}) WINS!"
    when 'checkmate'
      puts "CHECKMATE! #{@current_player.name} loses!"
      enemy_name = @current_player == @player1 ? @player2.name : @player1.name
      puts "#{enemy_name} WINS!"
    when 'stalemate'
      puts "STALEMATE! It's a draw!"
    end
  end
end
