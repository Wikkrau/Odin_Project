require_relative 'constants'
require_relative 'code_maker'
require_relative 'code_breaker'
require_relative 'board'

class Game
  include Settings

  def initialize
    puts 'MODE: (1) You guess | (2) AI guesses your code'
    mode = gets.chomp.to_i
    puts 'Enable high-contrast mode? (y/n)'
    @high_contrast = gets.chomp.downcase == 'y'

    if mode == 1
      @code = CodeMaker.new.code
      @breaker = CodeBreaker.new(@code)
    else
      @code = CodeMaker.new(human: true).code
      @breaker = CodeBreaker.new(@code, ai: true)
    end

    @board = Board.new(@high_contrast)
  end

  def display_rules
    puts "\n🎯 Welcome to Mastermind!"
    puts 'Your goal: guess the secret code using colour hints.'

    black_peg = @high_contrast ? '■'.colorize(:black).on_yellow : '⬛'
    white_peg = @high_contrast ? '□'.colorize(:white).on_red    : '⬜'

    puts "\nFeedback pegs:"
    puts "  #{black_peg}  - correct color in the correct position"
    puts "  #{white_peg}  - correct color in the wrong position"

    puts "\nYou have #{MAX_TURNS} guesses. Good luck!\n\n"
  end

  def play
    display_rules
    MAX_TURNS.times do |turn|
      puts "\nTurn #{turn + 1}/#{MAX_TURNS}"
      guess = @breaker.get_guess
      feedback = @board.give_feedback(@code.dup, guess.dup)
      puts "Guess:    #{guess.join}"
      puts "Feedback: #{feedback.join(' ')}"
      puts "Code is: #{@code.join(' ')}"

      # Check if all positions are correct (win condition)
      if won?(guess)
        puts 'You won!'
        break
      end
    end
  end

  private

  def won?(guess)
    # Check if the guess matches the code exactly
    guess == @code
  end
end
