require_relative 'spec_helper'
require_relative '../Lib/constants'
require_relative '../Lib/pieces_loader'
require_relative '../Lib/Board'

RSpec.describe Pawn do
  let(:board) { Board.new }

  describe '#possible_moves' do
    context 'white pawn' do
      let(:white_pawn) { Pawn.new('white', [1, 4]) }

      before do
        board.clear_board
        board.place_piece(white_pawn, [1, 4])
      end

      it 'can move one square forward' do
        moves = white_pawn.possible_moves(board)
        expect(moves).to include([2, 4])
      end

      it 'can move two squares from starting position' do
        moves = white_pawn.possible_moves(board)
        expect(moves).to include([2, 4], [3, 4])
      end

      it 'cannot move two squares after first move' do
        white_pawn.move_to([2, 4])
        board.move_piece([1, 4], [2, 4])

        moves = white_pawn.possible_moves(board)
        expect(moves).to include([3, 4])
        expect(moves).not_to include([4, 4])
      end

      it 'can capture diagonally' do
        enemy_pawn = Pawn.new('black', [2, 3])
        board.place_piece(enemy_pawn, [2, 3])

        moves = white_pawn.possible_moves(board)
        expect(moves).to include([2, 3]) # Diagonal capture
      end

      it 'cannot capture forward' do
        blocking_pawn = Pawn.new('black', [2, 4])
        board.place_piece(blocking_pawn, [2, 4])

        moves = white_pawn.possible_moves(board)
        expect(moves).not_to include([2, 4], [3, 4])
      end

      it 'cannot capture friendly pieces' do
        friendly_pawn = Pawn.new('white', [2, 3])
        board.place_piece(friendly_pawn, [2, 3])

        moves = white_pawn.possible_moves(board)
        expect(moves).not_to include([2, 3])
      end
    end

    context 'black pawn' do
      let(:black_pawn) { Pawn.new('black', [6, 4]) }

      before do
        board.clear_board
        board.place_piece(black_pawn, [6, 4])
      end

      it 'moves in opposite direction to white' do
        moves = black_pawn.possible_moves(board)
        expect(moves).to include([5, 4], [4, 4]) # Moving "down" the board
      end

      it 'can capture diagonally in correct direction' do
        enemy_pawn = Pawn.new('white', [5, 3])
        board.place_piece(enemy_pawn, [5, 3])

        moves = black_pawn.possible_moves(board)
        expect(moves).to include([5, 3])
      end
    end
  end
end
