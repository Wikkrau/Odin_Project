# Connect 4 Game Ting 🔴🟡

Wah gwaan! This yah a wicked Ruby implementation of the classic Connect 4 game, built with some serious OOP vibes and TDD flex, seen?

## 🎮 What This Bout

Connect 4 is a mad ting where two players drop their pieces inna vertical grid, trying fi be the first one to link up four pieces in a row - horizontal, vertical, or diagonal style. Pure fire gameplay!

## 🚀 What We Got Here

- **Two player madness** with X and O symbols
- **Dynamic winning conditions** - change up the rules however yuh want
- **Solid input validation** - no foolishness allowed
- **Full game detection** - wins, ties, and when man try some sketchy moves
- **Clean OOP design** - everything organized proper
- **Bare test coverage** - RSpec ting locked down

## 📁 How We Set Up

```
Connect4/
├── Lib/
│   ├── Board.rb        # The grid and win checking madness
│   ├── Game.rb         # Game flow and player switching ting  
│   ├── Player.rb       # Player class innit
│   └── Constants.rb    # All the config settings dem
├── spec/
│   ├── spec_board.rb   # Board testing vibes
│   └── spec_game.rb    # Game testing scenarios
├── main.rb             # Start the madness here
└── Readme.md          # This file yuh reading now
```

## 🛠️ Get This Running

1. **Grab the code:**
   ```bash
   git clone <your-repo-url>
   cd Connect4
   ```

2. **Sort the dependencies:**
   ```bash
   gem install rspec
   ```

3. **Fire it up:**
   ```bash
   ruby main.rb
   ```

## 🎯 How Fi Play This

1. Yuh get a 7x6 grid (7 columns, 6 rows) - standard Connect 4 vibes
2. Players take turns picking columns (1-6) 
3. Pieces drop down like gravity doing its ting
4. First one to connect 4 pieces inna row wins the whole ting!
5. If the board full up and nobody win - that's a draw, bredrin

## ⚙️ Customize the Settings

Want fi change up the game? Check `Constants.rb`:

```ruby
module Settings
  Board_width = 7        # How many columns yuh want
  Board_height = 6       # How many rows fi the madness  
  WINNING_LENGTH = 4     # How many pieces fi win
end
```

Want fi play Connect 5? Just bump up that `WINNING_LENGTH` - easy!

## 🧪 Test the Ting

Run all the tests dem:

```bash
# Test everything
rspec

# Test specific files if yuh want
rspec spec/spec_board.rb
rspec spec/spec_game.rb
```

## 🏗️ How We Built This

### The Classes Dem

- **`Game`** - The main controller, handles all the user input and turn switching
- **`Board`** - Manages the grid, piece dropping, and checking fi wins
- **`Player`** - Just represents each player with their name and symbol
- **`Settings`** - All the config settings inna one place

### The Nice Features

- **Smart win detection** - works with any winning length yuh set
- **Bulletproof validation** - can't break this with bad inputs
- **Clean code structure** - each class minds its own business
- **Proper error handling** - no crashes when things get sticky

## 🎨 How It Look When Playing

```
. . . . . .
. . . . . .
. . . . . .
. . . . . .
. . . O . .
. . X X . .
X O X O . .

Player X's turn. Choose column (1-6):
```

## 🤝 Want Fi Contribute?

Bredrin, feel free fi fork this and send some pull requests if yuh got improvements! We welcome all the good vibes.

## 📄 License

This yah project open source under MIT License - use it how yuh want, seen?

---

**Built with bare love using Ruby and TDD - one love! 🇯🇲**