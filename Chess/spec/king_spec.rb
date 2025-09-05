require_relative 'spec_helper'
require_relative '../Lib/constants'
require_relative '../Lib/pieces_loader'
require_relative '../Lib/Board'

RSpec.describe King do
  let(:board) { Board.new }
  let(:king) { King.new('white', [3, 3]) }

  before do
    board.clear_board
    board.place_piece(king, [3, 3])
  end

  describe '#possible_moves' do
    it 'moves one square in any direction' do
      moves = king.possible_moves(board)

      expected_moves = [
        [2, 2], [2, 3], [2, 4],  # Row above
        [3, 2],         [3, 4],  # Same row (left/right)
        [4, 2], [4, 3], [4, 4]   # Row below
      ]

      expect(moves.sort).to eq(expected_moves.sort)
      expect(moves.length).to eq(8)
    end

    it 'cannot move off board' do
      corner_king = King.new('white', [0, 0])
      board.place_piece(corner_king, [0, 0])

      moves = corner_king.possible_moves(board)

      # Only 3 valid moves from corner
      expect(moves).to contain_exactly([0, 1], [1, 0], [1, 1])
    end

    it 'can capture enemy pieces' do
      enemy_pawn = Pawn.new('black', [2, 2])
      board.place_piece(enemy_pawn, [2, 2])

      moves = king.possible_moves(board)
      expect(moves).to include([2, 2])
    end

    it 'cannot capture friendly pieces' do
      friendly_pawn = Pawn.new('white', [2, 2])
      board.place_piece(friendly_pawn, [2, 2])

      moves = king.possible_moves(board)
      expect(moves).not_to include([2, 2])
    end
  end
end
