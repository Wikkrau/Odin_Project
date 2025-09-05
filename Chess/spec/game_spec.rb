require_relative 'spec_helper'

RSpec.describe Game do
  let(:game) { Game.new }

  describe '#initialize' do
    it 'sets up initial game state' do
      expect(game.board).to be_a(Board)
      expect(game.current_player.color).to eq('white')
      expect(game.game_over).to be false
    end
  end

  describe '#notation_to_position' do
    it 'converts chess notation to array position' do
      expect(game.send(:notation_to_position, 'a1')).to eq([0, 0])
      expect(game.send(:notation_to_position, 'e4')).to eq([3, 4])
      expect(game.send(:notation_to_position, 'h8')).to eq([7, 7])
    end

    it 'returns nil for invalid notation' do
      expect(game.send(:notation_to_position, 'z9')).to be_nil
      expect(game.send(:notation_to_position, 'a0')).to be_nil
      expect(game.send(:notation_to_position, 'i1')).to be_nil
    end
  end

  describe '#position_to_notation' do
    it 'converts array position to chess notation' do
      expect(game.send(:position_to_notation, [0, 0])).to eq('a1')
      expect(game.send(:position_to_notation, [3, 4])).to eq('e4')
      expect(game.send(:position_to_notation, [7, 7])).to eq('h8')
    end
  end

  describe '#switch_players' do
    it 'switches between white and black players' do
      expect(game.current_player.color).to eq('white')

      game.send(:switch_players)
      expect(game.current_player.color).to eq('black')

      game.send(:switch_players)
      expect(game.current_player.color).to eq('white')
    end
  end

  describe '#valid_move?' do
    it 'returns true for valid pawn move' do
      pawn = game.board.piece_at([1, 4])
      result = game.send(:valid_move?, pawn, [1, 4], [3, 4])
      expect(result).to be true
    end

    it 'returns false for invalid move' do
      pawn = game.board.piece_at([1, 4])
      result = game.send(:valid_move?, pawn, [1, 4], [5, 5])
      expect(result).to be false
    end
  end

  describe '#execute_move' do
    it 'successfully executes valid move' do
      from_pos = [1, 4]
      to_pos = [3, 4]

      result = game.send(:execute_move, from_pos, to_pos)

      expect(result).to be true
      expect(game.board.piece_at(from_pos)).to be_nil
      expect(game.board.piece_at(to_pos)).to be_a(Pawn)
    end

    it 'detects king capture and ends game' do
      # Set up scenario where king can be captured
      game.board.clear_board
      white_king = King.new('white', [4, 4])
      black_rook = Rook.new('black', [4, 0])

      game.board.place_piece(white_king, [4, 4])
      game.board.place_piece(black_rook, [4, 0])

      # Switch to black player
      game.send(:switch_players)

      result = game.send(:execute_move, [4, 0], [4, 4])

      expect(result).to be true
      expect(game.game_over).to be true
    end
  end

  describe 'game end conditions' do
    it 'ends game when king is captured' do
      game.board.clear_board
      white_king = King.new('white', [0, 0])
      black_rook = Rook.new('black', [0, 7])

      game.board.place_piece(white_king, [0, 0])
      game.board.place_piece(black_rook, [0, 7])

      game.send(:switch_players) # Switch to black
      game.send(:execute_move, [0, 7], [0, 0])

      expect(game.game_over).to be true
    end
  end
end
