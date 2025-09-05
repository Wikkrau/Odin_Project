require_relative 'spec_helper'
require_relative '../Lib/constants'
require_relative '../Lib/pieces_loader'
require_relative '../Lib/Board'

RSpec.describe Piece do
  let(:white_piece) { Rook.new('white', [0, 0]) }
  let(:black_piece) { Rook.new('black', [7, 7]) }

  describe '#initialize' do
    it 'sets color and position' do
      expect(white_piece.color).to eq('white')
      expect(white_piece.position).to eq([0, 0])
      expect(white_piece.has_moved).to be false
    end
  end

  describe '#move_to' do
    it 'updates position and sets has_moved' do
      white_piece.move_to([2, 2])

      expect(white_piece.position).to eq([2, 2])
      expect(white_piece.has_moved).to be true
    end
  end

  describe '#enemy?' do
    it 'returns true for opposite color piece' do
      expect(white_piece.enemy?(black_piece)).to be true
      expect(black_piece.enemy?(white_piece)).to be true
    end

    it 'returns false for same color piece' do
      white_piece2 = Pawn.new('white', [1, 1])
      expect(white_piece.enemy?(white_piece2)).to be false
    end

    it 'returns false for nil' do
      expect(white_piece.enemy?(nil)).to be false
    end
  end

  describe '#ally?' do
    it 'returns true for same color piece' do
      white_piece2 = Pawn.new('white', [1, 1])
      expect(white_piece.ally?(white_piece2)).to be true
    end

    it 'returns false for opposite color piece' do
      expect(white_piece.ally?(black_piece)).to be false
    end

    it 'returns false for nil' do
      expect(white_piece.ally?(nil)).to be false
    end
  end

  describe '#symbol' do
    it 'returns colored symbol for piece' do
      symbol = white_piece.symbol
      expect(symbol).to include('R') # Rook symbol
      expect(symbol).to include("\e[97m") # White color code
    end
  end

  describe '#value' do
    it 'returns piece value from constants' do
      expect(white_piece.value).to eq(5) # Rook value

      pawn = Pawn.new('white', [1, 0])
      expect(pawn.value).to eq(1)

      queen = Queen.new('white', [0, 3])
      expect(queen.value).to eq(9)
    end
  end
end
