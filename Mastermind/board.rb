# board.rb
require_relative 'constants'
require 'colorize'
include Settings

class Board
  def initialize(high_contrast = false)
    @high_contrast = high_contrast
  end

  def give_feedback(code, guess)
    feedback = []

    code_flags = Array.new(SEQ_LENGTH, false)
    guess_flags = Array.new(SEQ_LENGTH, false)

    # Step 1: Black pegs (correct color, correct position)
    SEQ_LENGTH.times do |i|
      next unless guess[i] == code[i]

      feedback << (@high_contrast ? '■'.colorize(:black).on_yellow : '■'.colorize(:black))
      code_flags[i] = true
      guess_flags[i] = true
    end

    # Step 2: White pegs (correct color, wrong position)
    SEQ_LENGTH.times do |i|
      next if guess_flags[i]

      SEQ_LENGTH.times do |j|
        next if code_flags[j]
        next unless guess[i] == code[j]

        feedback << (@high_contrast ? '□'.colorize(:white).on_red : '■'.colorize(:white))
        code_flags[j] = true
        guess_flags[i] = true
        break
      end
    end

    feedback += ["''"] * (SEQ_LENGTH - feedback.size)
    feedback
  end
end
