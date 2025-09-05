require_relative 'spec_helper'

RSpec.describe Rook do
  let(:board) { Board.new }
  let(:rook) { Rook.new('white', [3, 3]) }

  before do
    board.clear_board
    board.place_piece(rook, [3, 3])
  end

  describe '#possible_moves' do
    context 'on empty board' do
      it 'can move in all four directions' do
        moves = rook.possible_moves(board)

        # Horizontal moves (row 3)
        expect(moves).to include([3, 0], [3, 1], [3, 2], [3, 4], [3, 5], [3, 6], [3, 7])

        # Vertical moves (column 3)
        expect(moves).to include([0, 3], [1, 3], [2, 3], [4, 3], [5, 3], [6, 3], [7, 3])

        # Should have exactly 14 moves (7 horizontal + 7 vertical)
        expect(moves.length).to eq(14)
      end
    end

    context 'with friendly pieces blocking' do
      it 'stops before friendly piece' do
        friendly_piece = Pawn.new('white', [3, 5])
        board.place_piece(friendly_piece, [3, 5])

        moves = rook.possible_moves(board)

        # Can move to [3, 4] but not [3, 5] or beyond
        expect(moves).to include([3, 4])
        expect(moves).not_to include([3, 5], [3, 6], [3, 7])
      end
    end

    context 'with enemy pieces' do
      it 'can capture enemy piece but not move beyond' do
        enemy_piece = Pawn.new('black', [3, 5])
        board.place_piece(enemy_piece, [3, 5])

        moves = rook.possible_moves(board)

        # Can move to and capture [3, 5] but not beyond
        expect(moves).to include([3, 4], [3, 5])
        expect(moves).not_to include([3, 6], [3, 7])
      end
    end

    context 'at board edges' do
      it 'cannot move off the board' do
        corner_rook = Rook.new('white', [0, 0])
        board.place_piece(corner_rook, [0, 0])

        moves = corner_rook.possible_moves(board)

        # Should only have moves along row 0 and column 0
        expect(moves.all? { |row, col| row == 0 || col == 0 }).to be true
        expect(moves.all? { |row, col| row >= 0 && row <= 7 && col >= 0 && col <= 7 }).to be true
      end
    end
  end
end
