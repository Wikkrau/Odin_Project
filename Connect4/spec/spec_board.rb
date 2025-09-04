require_relative '../Lib/Board'
require_relative '../Lib/Player'

RSpec.describe Board do
  let(:board) { Board.new }
  let(:player_x) { Player.new('Player 1', 'X') }
  let(:player_o) { Player.new('Player 2', 'O') }

  describe '#initialize' do
    it 'creates an empty grid' do
      expect(board.grid.all? { |row| row.all?(&:nil?) }).to be true
    end

    it 'creates grid with correct dimensions' do
      expect(board.grid.length).to eq(7) # Board_width
      expect(board.grid[0].length).to eq(6) # Board_height
    end
  end

  describe '#drop_piece' do
    it 'drops piece to bottom of empty column' do
      board.drop_piece(0, player_x)
      expect(board.grid[6][0]).to eq('X')
    end

    it 'stacks pieces correctly' do
      board.drop_piece(0, player_x)
      board.drop_piece(0, player_o)

      expect(board.grid[6][0]).to eq('X')
      expect(board.grid[5][0]).to eq('O')
    end

    it 'does not drop piece in full column' do
      # Fill column 0 completely (7 pieces since there are 7 rows)
      7.times { board.drop_piece(0, player_x) }

      # Try to drop one more piece - should not be placed
      board.drop_piece(0, player_o)

      # Check that top spot is still X (not O)
      expect(board.grid[0][0]).to eq('X')
      # Check that no O pieces were added
      expect(board.grid.flatten.count('O')).to eq(0)
    end
  end

  describe '#full?' do
    it 'returns false for empty board' do
      expect(board.full?).to be false
    end

    it 'returns true when board is completely full' do
      board.grid.each_with_index do |row, r|
        row.each_with_index do |_, c|
          board.grid[r][c] = 'X'
        end
      end

      expect(board.full?).to be true
    end
  end

  describe '#check_horizontal' do
    it 'returns true for horizontal win' do
      # Place 4 X's horizontally
      (0..3).each { |col| board.grid[6][col] = 'X' }

      expect(board.check_horizontal('X')).to be true
    end

    it 'returns false when no horizontal win' do
      board.grid[6][0] = 'X'
      board.grid[6][1] = 'O'
      board.grid[6][2] = 'X'

      expect(board.check_horizontal('X')).to be false
    end
  end

  describe '#check_vertical' do
    it 'returns true for vertical win' do
      # Place 4 X's vertically
      (3..6).each { |row| board.grid[row][0] = 'X' }

      expect(board.check_vertical('X')).to be true
    end

    it 'returns false when no vertical win' do
      board.grid[6][0] = 'X'
      board.grid[5][0] = 'O'
      board.grid[4][0] = 'X'

      expect(board.check_vertical('X')).to be false
    end
  end

  describe '#check_diagonal' do
    it 'returns true for diagonal win (down-right)' do
      # Place 4 X's diagonally
      board.grid[3][0] = 'X'
      board.grid[4][1] = 'X'
      board.grid[5][2] = 'X'
      board.grid[6][3] = 'X'

      expect(board.check_diagonal('X')).to be true
    end

    it 'returns true for diagonal win (down-left)' do
      # Place 4 X's diagonally
      board.grid[3][3] = 'X'
      board.grid[4][2] = 'X'
      board.grid[5][1] = 'X'
      board.grid[6][0] = 'X'

      expect(board.check_diagonal('X')).to be true
    end

    it 'returns false when no diagonal win' do
      board.grid[6][0] = 'X'
      board.grid[5][1] = 'O'
      board.grid[4][2] = 'X'

      expect(board.check_diagonal('X')).to be false
    end
  end

  describe '#winning_combination?' do
    it 'returns true when player has winning combination' do
      # Set up horizontal win
      (0..3).each { |col| board.grid[6][col] = 'X' }

      expect(board.winning_combination?(player_x)).to be true
    end

    it 'returns false when player has no winning combination' do
      board.grid[6][0] = 'X'
      board.grid[6][1] = 'O'

      expect(board.winning_combination?(player_x)).to be false
    end
  end
end
