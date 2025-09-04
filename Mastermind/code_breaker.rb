require_relative 'constants'
include Settings

class CodeBreaker
  attr_reader :guess

  def initialize(code, ai: false)
    @code = code
    @ai = ai
  end

  def get_guess
    if @ai
      generate_ai_guess
    else
      get_human_guess
    end
  end

  private

  def generate_ai_guess
    # For now, a random guess:
    Array.new(SEQ_LENGTH) { COLORS.sample }
  end

  def get_human_guess
    loop do
      print "Enter your guess (#{SEQ_LENGTH} letters from #{COLORS.join(', ')}): "
      input = gets.chomp.upcase.chars
      return input if input.length == SEQ_LENGTH && (input - COLORS).empty?

      puts 'Invalid guess.'
    end
  end
end
