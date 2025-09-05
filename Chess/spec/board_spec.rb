require_relative 'spec_helper'
require_relative '../Lib/constants'
require_relative '../Lib/pieces_loader'
require_relative '../Lib/Board'

RSpec.describe Board do
  let(:board) { Board.new }

  describe '#initialize' do
    it 'creates an 8x8 grid' do
      expect(board.grid.length).to eq(8)
      expect(board.grid.all? { |row| row.length == 8 }).to be true
    end

    it 'sets up starting pieces correctly' do
      # White pieces on bottom rows (0-1)
      expect(board.piece_at([0, 0])).to be_a(Rook)
      expect(board.piece_at([0, 0]).color).to eq('white')
      expect(board.piece_at([0, 4])).to be_a(King)
      expect(board.piece_at([1, 0])).to be_a(Pawn)

      # Black pieces on top rows (6-7)
      expect(board.piece_at([7, 0])).to be_a(Rook)
      expect(board.piece_at([7, 0]).color).to eq('black')
      expect(board.piece_at([7, 4])).to be_a(King)
      expect(board.piece_at([6, 0])).to be_a(Pawn)

      # Empty squares in middle
      expect(board.piece_at([2, 2])).to be_nil
      expect(board.piece_at([3, 3])).to be_nil
    end
  end

  describe '#piece_at' do
    it 'returns piece at valid position' do
      piece = board.piece_at([0, 0])
      expect(piece).to be_a(Rook)
      expect(piece.color).to eq('white')
    end

    it 'returns nil for empty squares' do
      expect(board.piece_at([3, 3])).to be_nil
    end

    it 'returns nil for invalid positions' do
      expect(board.piece_at([-1, 0])).to be_nil
      expect(board.piece_at([8, 0])).to be_nil
    end
  end

  describe '#move_piece' do
    it 'moves piece from one position to another' do
      pawn = board.piece_at([1, 4])
      result = board.move_piece([1, 4], [3, 4])

      expect(result).to be true
      expect(board.piece_at([1, 4])).to be_nil
      expect(board.piece_at([3, 4])).to eq(pawn)
      expect(pawn.position).to eq([3, 4])
    end

    it 'returns false when no piece at source position' do
      result = board.move_piece([3, 3], [4, 4])
      expect(result).to be false
    end

    it 'captures enemy piece' do
      board.move_piece([1, 4], [6, 4]) # Move white pawn to black pawn position
      expect(board.piece_at([6, 4])).to be_a(Pawn)
      expect(board.piece_at([6, 4]).color).to eq('white')
    end
  end

  describe '#deep_copy' do
    it 'creates independent copy of board' do
      copy = board.deep_copy

      # Move piece on original board
      board.move_piece([1, 0], [3, 0])

      # Copy should be unchanged
      expect(copy.piece_at([1, 0])).to be_a(Pawn)
      expect(copy.piece_at([3, 0])).to be_nil
    end
  end
end
