# Chess Game - Definitions & Structure Helper

## 📁 **Project Structure Overview**

```
Chess/
├── main.rb                    # Entry point - starts the game
├── planer.txt                # Your planning document
├── readme.md                 # Project documentation
├── .rspec                    # RSpec configuration
├── Lib/                      # Main code directory
│   ├── constants.rb          # Game constants (board size, symbols, values)
│   ├── Board.rb              # Chess board class - manages piece positions
│   ├── Game.rb               # Main game logic - handles turns, input, game flow
│   ├── player.rb             # Player class - stores name and color
│   ├── CheckSystem.rb        # Module for check/checkmate/stalemate detection
│   ├── DisplayHelpers.rb     # Module for screen clearing and status messages
│   ├── MoveValidator.rb      # Module for validating moves (if used)
│   ├── SaveLoad.rb           # Module for saving/loading games (if used)
│   └── chess/
│       └── Pieces/           # All chess piece classes
│           ├── Piece.rb      # Parent class - common methods for all pieces
│           ├── Pawn.rb       # Pawn movement logic
│           ├── Rook.rb       # Rook movement logic
│           ├── Knight.rb     # Knight movement logic
│           ├── Bishop.rb     # Bishop movement logic
│           ├── Queen.rb      # Queen movement logic
│           └── King.rb       # King movement logic
└── spec/                     # Test files directory
    └── spec_helper.rb        # RSpec test configuration
```

---

## 🎯 **Main Classes & Their Purpose**

### **Game Class** (`Lib/Game.rb`)
- **Purpose**: Controls the entire game flow, handles user input, manages turns
- **Key Responsibilities**: 
  - Two-step piece selection (select piece → select destination)
  - Input validation and processing
  - Turn switching between players
  - Game end detection

### **Board Class** (`Lib/Board.rb`) 
- **Purpose**: Manages the 8x8 chess board and piece positions
- **Key Responsibilities**:
  - Store piece positions in 2D array
  - Handle piece movement
  - Initial board setup
  - Display board to screen

### **Piece Classes** (`Lib/chess/Pieces/`)
- **Purpose**: Define how each chess piece moves
- **Inheritance**: All pieces inherit from `Piece` parent class
- **Each piece implements**: `possible_moves(board)` method

### **Player Class** (`Lib/player.rb`)
- **Purpose**: Simple class to store player information
- **Stores**: Player name and color (white/black)

---

## 🔧 **Game.rb Functions Explained**

### **Public Methods**

#### `initialize`
- **What it does**: Sets up new game
- **Creates**: Board, two players, sets white to go first
- **Variables**: `@board`, `@player1`, `@player2`, `@current_player`, `@game_over`, `@selected_piece`, `@selected_position`

#### `play`
- **What it does**: Main game loop - runs until game ends
- **Flow**: Display board → get user input → process input → repeat
- **Handles**: All user commands (quit, restart, cancel, piece selection)

---

### **Private Helper Methods**

#### `handle_position_input(position)`
- **Purpose**: Decides what to do with chess notation input (e.g., "e2")
- **Logic**: If no piece selected → select piece, if piece selected → move to destination
- **Example**: "e2" first selects pawn, "e4" then moves it

#### `select_piece(position)`
- **Purpose**: Select a piece for moving
- **Validates**: 
  - Piece exists at position
  - Piece belongs to current player
  - Piece has legal moves available
  - If in check, piece can help escape check
- **Output**: Shows selected piece and available moves

#### `move_to_destination(destination)`
- **Purpose**: Move selected piece to destination
- **Validates**:
  - Move is legal for that piece type
  - Move doesn't leave king in check
  - Move gets out of check (if currently in check)
- **Actions**: Executes move, shows capture message, switches players, checks game end

#### `valid_move?(piece, from_pos, to_pos)`
- **Purpose**: Check if a move is legal according to piece rules
- **How**: Calls `piece.possible_moves(board)` and sees if destination is included
- **Returns**: `true` if legal, `false` if illegal

#### `get_legal_moves(piece, from_pos)`
- **Purpose**: Get all legal moves for a piece
- **Currently**: Just returns `piece.possible_moves(board)`
- **Future**: Could filter out moves that put king in check

#### `find_king(color)`
- **Purpose**: Find the king piece of specified color on board
- **How**: Searches through all pieces on board
- **Returns**: King piece object or `nil` if not found

#### `no_legal_moves?(color)`
- **Purpose**: Check if player has any legal moves available
- **Used for**: Stalemate detection
- **How**: Checks every piece of that color for possible moves

#### `cancel_selection`
- **Purpose**: Deselect currently selected piece
- **Resets**: `@selected_piece` and `@selected_position` to `nil`
- **User trigger**: Type "cancel" command

#### `show_selection_status`
- **Purpose**: Display current game state to user
- **Shows**: Current player, selected piece (if any), position

#### `notation_to_position(notation)` 
- **Purpose**: Convert chess notation to array coordinates
- **Example**: "e2" → [1, 4] (row 1, column 4)
- **Formula**: column = letter - 'a', row = number - 1

#### `position_to_notation(position)`
- **Purpose**: Convert array coordinates to chess notation  
- **Example**: [1, 4] → "e2"
- **Formula**: letter = column + 'a', number = row + 1

#### `restart_game`
- **Purpose**: Reset game to starting position
- **Actions**: New board, reset to player1, clear selection

#### `switch_players`
- **Purpose**: Change active player
- **Logic**: If player1 → switch to player2, if player2 → switch to player1

#### `check_game_end`
- **Purpose**: Check if game is over (checkmate/stalemate)
- **Calls**: `checkmate?()` and `stalemate?()` methods from CheckSystem module

---

## 🔍 **CheckSystem.rb Module Functions**

#### `king_in_check?(color)`
- **Purpose**: Check if specified color's king is under attack
- **How**: Find king, check if any enemy piece can attack its position
- **Returns**: `true` if in check, `false` if safe

#### `move_escapes_check?(from_pos, to_pos)`
- **Purpose**: Test if a move would get king out of check
- **How**: Simulate move on copy of board, check if king still in check
- **Used**: To validate moves when player is in check

#### `king_would_be_in_check_on_board?(board, color)`
- **Purpose**: Check if king would be in check on a specific board state
- **Used**: For move simulation and validation

#### `get_moves_that_escape_check(piece, from_pos)`
- **Purpose**: Get only the moves that would escape check
- **How**: Test each possible move to see if it escapes check
- **Returns**: Array of positions that would get out of check

#### `checkmate?(color)`
- **Purpose**: Check if player is in checkmate (game over)
- **Logic**: King in check AND no moves can escape check
- **Returns**: `true` if checkmate, `false` otherwise

#### `stalemate?(color)`
- **Purpose**: Check if game is stalemate (draw)
- **Logic**: King NOT in check AND no legal moves available
- **Returns**: `true` if stalemate, `false` otherwise

#### `no_moves_escape_check?(color)`
- **Purpose**: Check if player has any moves that escape check
- **Used**: For checkmate detection
- **How**: Tests every possible move to see if any escape check

---

## 🎨 **DisplayHelpers.rb Module Functions**

#### `clear_screen`
- **Purpose**: Clear terminal screen for clean display
- **How**: Uses system commands `clear` (Linux/Mac) or `cls` (Windows)

#### `show_check_status`
- **Purpose**: Display check warnings to players
- **Shows**: Red warning if current player in check, yellow if enemy in check

#### `show_capture_message(captured_piece)`
- **Purpose**: Display message when piece is captured
- **Example**: "Captured pawn!" or "Captured queen!"

#### `show_move_message(piece_name, from_notation, destination)`
- **Purpose**: Display successful move
- **Example**: "Moved pawn from e2 to e4"

#### `show_game_end_message(winner, type)`
- **Purpose**: Display game over messages
- **Types**: 'capture' (king taken), 'checkmate', 'stalemate'
- **Examples**: "CHECKMATE! Player 1 wins!" or "STALEMATE! It's a draw!"

---

## 🏗️ **Object Relationships**

### **Inheritance Hierarchy**
```
Piece (parent class)
├── Pawn (child)
├── Rook (child)  
├── Knight (child)
├── Bishop (child)
├── Queen (child)
└── King (child)
```

### **Composition Relationships**
- **Game** contains **Board** (has-a relationship)
- **Game** contains **Players** (has-a relationship)  
- **Board** contains **Pieces** (has-a relationship)
- **Game** uses **CheckSystem** (module inclusion)
- **Game** uses **DisplayHelpers** (module inclusion)

### **Data Flow**
1. **User Input** → **Game.play**
2. **Game** calls **Board** methods to check/move pieces
3. **Board** calls **Piece** methods to validate moves
4. **Game** uses **CheckSystem** to detect check/mate
5. **Game** uses **DisplayHelpers** to show messages

---

## 🎮 **How the Game Works (Flow)**

1. **Game starts**: Board setup, display welcome message
2. **Game loop begins**: 
   - Clear screen
   - Display board
   - Show whose turn it is
   - Wait for user input
3. **User selects piece**: Game validates and highlights legal moves
4. **User selects destination**: Game validates move, executes if legal
5. **After move**: Check for captures, check/checkmate, switch players
6. **Repeat** until game ends (checkmate, stalemate, or quit)

---

## 📝 **File Extensions**
- **.rb files**: Ruby code files
- **.md files**: Markdown documentation (like this file) - supports formatting
- **.txt files**: Plain text files - no formatting

**Difference**: .md files support headers, lists, code blocks, bold text, etc. .txt files are just plain text.

---

## 🚀 **How to Navigate This Project**

1. **Start with**: `main.rb` to see entry point
2. **Main logic**: `Game.rb` - understand game flow
3. **Board management**: `Board.rb` - see how pieces are stored/moved  
4. **Piece logic**: Look at individual piece files for movement rules
5. **Game features**: Check modules for advanced features (check detection, display)
6. **Constants**: `constants.rb` for game configuration values

**Pro tip**: Use this file as a reference when you forget what a function does! 🎯