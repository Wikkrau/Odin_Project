require_relative 'spec_helper'
require_relative '../Lib/constants'
require_relative '../Lib/pieces_loader'
require_relative '../Lib/Board'

RSpec.describe Knight do
  let(:board) { Board.new }
  let(:knight) { Knight.new('white', [3, 3]) }

  before do
    board.clear_board
    board.place_piece(knight, [3, 3])
  end

  describe '#possible_moves' do
    it 'moves in L-shape pattern' do
      moves = knight.possible_moves(board)

      expected_moves = [
        [1, 2], [1, 4],  # Up 2, left/right 1
        [2, 1], [2, 5],  # Up 1, left/right 2
        [4, 1], [4, 5],  # Down 1, left/right 2
        [5, 2], [5, 4]   # Down 2, left/right 1
      ]

      expect(moves.sort).to eq(expected_moves.sort)
    end

    it 'can jump over pieces' do
      # Place pieces around knight
      board.place_piece(Pawn.new('white', [2, 3]), [2, 3])
      board.place_piece(Pawn.new('white', [3, 2]), [3, 2])
      board.place_piece(Pawn.new('white', [3, 4]), [3, 4])
      board.place_piece(Pawn.new('white', [4, 3]), [4, 3])

      moves = knight.possible_moves(board)

      # Knight should still be able to move to L-shape positions
      expect(moves).to include([1, 2], [1, 4], [5, 2], [5, 4])
    end

    it 'cannot move off board' do
      corner_knight = Knight.new('white', [0, 0])
      board.place_piece(corner_knight, [0, 0])

      moves = corner_knight.possible_moves(board)

      # Only valid moves from corner
      expect(moves).to contain_exactly([1, 2], [2, 1])
    end

    it 'can capture enemy pieces' do
      enemy_pawn = Pawn.new('black', [1, 2])
      board.place_piece(enemy_pawn, [1, 2])

      moves = knight.possible_moves(board)
      expect(moves).to include([1, 2])
    end

    it 'cannot capture friendly pieces' do
      friendly_pawn = Pawn.new('white', [1, 2])
      board.place_piece(friendly_pawn, [1, 2])

      moves = knight.possible_moves(board)
      expect(moves).not_to include([1, 2])
    end
  end
end
