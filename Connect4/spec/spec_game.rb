require_relative '../Lib/Game'
require_relative '../Lib/Board'
require_relative '../Lib/Player'

RSpec.describe Game do
  let(:game) { Game.new }

  describe '#initialize' do
    it 'creates a new board' do
      expect(game.instance_variable_get(:@board)).to be_a(Board)
    end

    it 'creates two players' do
      player1 = game.instance_variable_get(:@player1)
      player2 = game.instance_variable_get(:@player2)

      expect(player1).to be_a(Player)
      expect(player2).to be_a(Player)
      expect(player1.symbol).to eq('X')
      expect(player2.symbol).to eq('O')
    end

    it 'sets player1 as current player' do
      current_player = game.instance_variable_get(:@current_player)
      player1 = game.instance_variable_get(:@player1)

      expect(current_player).to eq(player1)
    end
  end

  describe '#valid_move?' do
    it 'returns true for valid column numbers' do
      expect(game.send(:valid_move?, 1)).to be true
      expect(game.send(:valid_move?, 6)).to be true
    end

    it 'returns false for invalid column numbers' do
      expect(game.send(:valid_move?, 0)).to be false
      expect(game.send(:valid_move?, 7)).to be false
      expect(game.send(:valid_move?, -1)).to be false
    end

    it 'returns false when column is full' do
      board = game.instance_variable_get(:@board)
      player = game.instance_variable_get(:@player1)

      # Fill column 1 (index 0)
      7.times { board.drop_piece(0, player) }

      expect(game.send(:valid_move?, 1)).to be false
    end
  end

  describe '#switch_player' do
    it 'switches from player1 to player2' do
      player1 = game.instance_variable_get(:@player1)
      player2 = game.instance_variable_get(:@player2)

      expect(game.instance_variable_get(:@current_player)).to eq(player1)

      game.send(:switch_player)

      expect(game.instance_variable_get(:@current_player)).to eq(player2)
    end

    it 'switches from player2 to player1' do
      player1 = game.instance_variable_get(:@player1)
      player2 = game.instance_variable_get(:@player2)

      game.instance_variable_set(:@current_player, player2)

      game.send(:switch_player)

      expect(game.instance_variable_get(:@current_player)).to eq(player1)
    end
  end
end
