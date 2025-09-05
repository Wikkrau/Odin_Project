require_relative 'spec_helper'
require_relative '../Lib/constants'
require_relative '../Lib/pieces_loader'
require_relative '../Lib/Board'

RSpec.describe Queen do
  let(:board) { Board.new }
  let(:queen) { Queen.new('white', [3, 3]) }

  before do
    board.clear_board
    board.place_piece(queen, [3, 3])
  end

  describe '#possible_moves' do
    it 'combines rook and bishop movement' do
      moves = queen.possible_moves(board)

      # Horizontal moves (like rook)
      expect(moves).to include([3, 0], [3, 1], [3, 2], [3, 4], [3, 5], [3, 6], [3, 7])

      # Vertical moves (like rook)
      expect(moves).to include([0, 3], [1, 3], [2, 3], [4, 3], [5, 3], [6, 3], [7, 3])

      # Diagonal moves (like bishop)
      expect(moves).to include([0, 0], [1, 1], [2, 2], [4, 4], [5, 5], [6, 6], [7, 7])
      expect(moves).to include([0, 6], [1, 5], [2, 4], [4, 2], [5, 1], [6, 0])

      expect(moves.length).to eq(27) # Maximum moves from center position
    end

    it 'is most powerful piece' do
      moves = queen.possible_moves(board)

      # Queen should have more moves than any other piece from center
      rook = Rook.new('white', [3, 3])
      board.place_piece(rook, [3, 3])
      rook_moves = rook.possible_moves(board)

      bishop = Bishop.new('white', [3, 3])
      board.place_piece(bishop, [3, 3])
      bishop_moves = bishop.possible_moves(board)

      expect(moves.length).to be > rook_moves.length
      expect(moves.length).to be > bishop_moves.length
    end
  end
end
