require_relative 'spec_helper'
require_relative '../Lib/constants'
require_relative '../Lib/pieces_loader'
require_relative '../Lib/Board'

RSpec.describe Bishop do
  let(:board) { Board.new }
  let(:bishop) { Bishop.new('white', [3, 3]) }

  before do
    board.clear_board
    board.place_piece(bishop, [3, 3])
  end

  describe '#possible_moves' do
    it 'moves diagonally in all four directions' do
      moves = bishop.possible_moves(board)

      # Up-right diagonal
      expect(moves).to include([4, 4], [5, 5], [6, 6], [7, 7])

      # Up-left diagonal
      expect(moves).to include([4, 2], [5, 1], [6, 0])

      # Down-right diagonal
      expect(moves).to include([2, 4], [1, 5], [0, 6])

      # Down-left diagonal
      expect(moves).to include([2, 2], [1, 1], [0, 0])

      expect(moves.length).to eq(13) # All diagonal squares from center
    end

    it 'stops at friendly pieces' do
      friendly_piece = Pawn.new('white', [5, 5])
      board.place_piece(friendly_piece, [5, 5])

      moves = bishop.possible_moves(board)

      # Can move to [4, 4] but not [5, 5] or beyond
      expect(moves).to include([4, 4])
      expect(moves).not_to include([5, 5], [6, 6], [7, 7])
    end

    it 'can capture enemy pieces but not move beyond' do
      enemy_piece = Pawn.new('black', [5, 5])
      board.place_piece(enemy_piece, [5, 5])

      moves = bishop.possible_moves(board)

      # Can capture [5, 5] but not move beyond
      expect(moves).to include([4, 4], [5, 5])
      expect(moves).not_to include([6, 6], [7, 7])
    end
  end
end
