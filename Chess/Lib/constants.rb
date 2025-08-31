module ChessSettings
  BOARD_SIZE = 8

  STARTING_POSITIONS = {
    'white' => {
      'rook' => [[0, 0], [0, 7]],
      'knight' => [[0, 1], [0, 6]],
      'bishop' => [[0, 2], [0, 5]],
      'queen' => [[0, 3]],
      'king' => [[0, 4]],
      'pawn' => (0..7).map { |col| [1, col] }
    },
    'black' => {
      'rook' => [[7, 0], [7, 7]],
      'knight' => [[7, 1], [7, 6]],
      'bishop' => [[7, 2], [7, 5]],
      'queen' => [[7, 3]],
      'king' => [[7, 4]],
      'pawn' => (0..7).map { |col| [6, col] }
    }
  }

  PIECE_VALUES = {
    'pawn' => 1,
    'knight' => 3,
    'bishop' => 3,
    'rook' => 5,
    'queen' => 9,
    'king' => 100
  }

  PIECE_SYMBOLS = {
    'white' => {
      'pawn' => '♙', 'rook' => '♖', 'knight' => '♘',
      'bishop' => '♗', 'queen' => '♕', 'king' => '♔'
    },
    'black' => {
      'pawn' => '♟', 'rook' => '♜', 'knight' => '♞',
      'bishop' => '♝', 'queen' => '♛', 'king' => '♚'
    }
  }
end
