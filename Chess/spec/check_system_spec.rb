require_relative 'spec_helper'
require_relative '../Lib/constants'
require_relative '../Lib/pieces_loader'
require_relative '../Lib/Board'
require_relative '../Lib/player'
require_relative '../Lib/CheckSystem'
require_relative '../Lib/DisplayHelpers'
require_relative '../Lib/Game'

RSpec.describe CheckSystem do
  let(:game) { Game.new }

  describe '#find_king' do
    it 'finds white king' do
      king = game.send(:find_king, 'white')
      expect(king).to be_a(King)
      expect(king.color).to eq('white')
      expect(king.position).to eq([0, 4])
    end

    it 'finds black king' do
      king = game.send(:find_king, 'black')
      expect(king).to be_a(King)
      expect(king.color).to eq('black')
      expect(king.position).to eq([7, 4])
    end
  end

  describe '#king_in_check?' do
    it 'returns false for starting position' do
      expect(game.send(:king_in_check?, 'white')).to be false
      expect(game.send(:king_in_check?, 'black')).to be false
    end

    it 'detects check from rook' do
      game.board.clear_board

      white_king = King.new('white', [4, 4])
      black_rook = Rook.new('black', [4, 0])

      game.board.place_piece(white_king, [4, 4])
      game.board.place_piece(black_rook, [4, 0])

      expect(game.send(:king_in_check?, 'white')).to be true
    end

    it 'detects check from bishop' do
      game.board.clear_board

      white_king = King.new('white', [4, 4])
      black_bishop = Bishop.new('black', [1, 1])

      game.board.place_piece(white_king, [4, 4])
      game.board.place_piece(black_bishop, [1, 1])

      expect(game.send(:king_in_check?, 'white')).to be true
    end

    it 'does not detect check when piece is blocked' do
      game.board.clear_board

      white_king = King.new('white', [4, 4])
      black_rook = Rook.new('black', [4, 0])
      blocking_pawn = Pawn.new('white', [4, 2])

      game.board.place_piece(white_king, [4, 4])
      game.board.place_piece(black_rook, [4, 0])
      game.board.place_piece(blocking_pawn, [4, 2])

      expect(game.send(:king_in_check?, 'white')).to be false
    end
  end

  describe '#checkmate?' do
    it 'detects basic checkmate scenario' do
      # Skip complex checkmate detection for now
      skip('Complex checkmate detection - will implement later')
    end
  end

  describe '#stalemate?' do
    it 'detects stalemate when king has no moves but not in check' do
      # Skip complex stalemate detection for now
      skip('Complex stalemate detection - will implement later')
    end
  end
end
