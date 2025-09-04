require_relative 'constants'

class CodeMaker
  include Settings

  attr_reader :code

  def initialize(human: false)
    @code = human ? get_human_code : generate_random_code
  end

  private

  def generate_random_code
    Array.new(SEQ_LENGTH) { COLORS.sample }
  end

  def get_human_code
    loop do
      print "Enter a #{SEQ_LENGTH}-letter code using #{COLORS.join(', ')}: "
      input = gets.chomp.upcase.chars
      return input if input.length == SEQ_LENGTH && (input - COLORS).empty?

      puts "Invalid input. Use only the letters #{COLORS.join(', ')}."
    end
  end
end
