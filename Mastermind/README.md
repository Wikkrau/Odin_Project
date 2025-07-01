# Odin Project — Ruby Mastermind

Welcome to my version of Mastermind, built as part of the Odin Project

---

##  How to Play

- Guess the **4-color code** within **12 turns**.
- Colors: R, O, Y, G, B, P (Red, Orange, Yellow, Green, Blue, Purple)
- You’ll get feedback after each guess:

  - `⬛` or `■` – Correct color, correct position
  - `⬜` or `□` – Correct color, wrong position

You can choose to play as **code breaker** or let the AI guess **your** secret code.

---

##  Features

- High contrast mode for better terminal visibility
- Simple AI algorithm that guesses your code
- Clear CLI output using the `colorize` gem
- Modular code structure (game logic, feedback board, code maker/breaker)

---

##  Getting Started

1. **Clone the repo**
   ```bash
   git clone https://github.com/Wikkrau/Odin_Project.git
   cd Odin_Project
