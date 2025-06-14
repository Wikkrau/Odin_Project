class Game
    def initialize()
        @board = Array.new(3) { Array.new(3, ' ') }
        @current_player = 'X'
    end
    def display_board
        puts "current board:"
        @board.each do |row|
            puts row.join('|')
            puts '-' * 5
        end
    end
    def make_move(row, col)
        if row < 0 || row > 2 || col < 0 || col > 2
            puts "Invalid move. Please choose a valid position."
            return false
        end
        if @board[row][col] != ' '
            puts "Position already taken. Please choose another position."
            return false
        end
        @board[row][col] = @current_player
        true
    end
    def switch_player
       if @current_player == 'X'
            @current_player = 'O'
        else
            @current_player = 'X'
        end
    end
    def check_winner
        range = [0, 1, 2]
        # Check rows and columns
        range.each do |i|
            return @current_player if @board[i].all? { |cell| cell == @current_player }
            return @current_player if @board.all? { |row| row[i] == @current_player }
        end
        # Check diagonals
        return @current_player if @board[0][0] == @current_player && @board[1][1] == @current_player && @board[2][2] == @current_player
        return @current_player if @board[0][2] == @current_player && @board[1][1] == @current_player && @board[2][0] == @current_player
        nil
    end
end

game_instance = Game.new
loop do
    game_instance.display_board
    puts "Player #{game_instance.instance_variable_get(:@current_player)}, enter your move (row and column):"
    input = gets.chomp.split.map(&:to_i)
    if input.length != 2
        puts "Invalid input. Please enter two numbers separated by a space."
        next
    end
    row, col = input
    if game_instance.make_move(row, col)
        winner = game_instance.check_winner
        if winner
            game_instance.display_board
            puts "Player #{winner} wins!"
            break
        end
        game_instance.switch_player
    end
end