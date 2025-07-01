require_relative 'constants'
require_relative 'filereader'

class Game
  include FileSystem
  include Settings

  def initialize
    @words = format('google-10000-english-no-swears.txt')
    # Filter words by the desired length
    filtered_words = @words.select { |word| word.length == Word_Length }
    @word = (filtered_words.empty? ? @words.sample : filtered_words.sample).downcase
    @guesses = []
    @turns_left = Max_Turns
  end

  def rules
    puts 'Welcome to Hangman!'
    puts "You have #{Max_Turns} turns to guess the word."
    puts "The word has #{@word.length} letters."
    puts 'Good luck!'
  end

  def display_word
    display = @word.chars.map { |char| @guesses.include?(char) ? char : '_' }.join(' ')
    puts "Word: #{display}"
  end

  def guess_valid
    puts 'Please enter a letter:'
    guess = gets.chomp.downcase
    if guess.length == 1 && ('a'..'z').include?(guess)
      if @guesses.include?(guess)
        puts "You already guessed '#{guess}'. Try again."
        false # Return false to indicate no valid guess was made
      else
        @guesses << guess
        if @word.include?(guess)
          puts "Good guess! The letter '#{guess}' is in the word."
        else
          @turns_left -= 1
          puts "Sorry, the letter '#{guess}' is not in the word. Turns left: #{@turns_left}"
        end
        true # Return true to indicate a valid guess was made
      end
    else
      puts 'Invalid input. Please enter a single letter.'
      false # Return false to indicate no valid guess was made
    end
  end

  def game_won?
    @word.chars.all? { |char| @guesses.include?(char) }
  end

  def play
    rules
    sleep(4)
    system('clear')

    while @turns_left > 0
      display_word

      # Only check for win condition after a valid guess
      if guess_valid && game_won?
        puts "\nCongratulations! You've guessed the word: #{@word.upcase}"
        return
      end

      puts # Add a blank line for better readability
    end

    # Game over - player ran out of turns
    puts "\nGame Over! You ran out of turns."
    puts "The word was: #{@word.upcase}"
  end
end
