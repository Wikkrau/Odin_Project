# frozen_string_literal: true

class Player
  attr_reader :name, :tag

  def initialize(name, tag)
    @name = name.capitalize
    @tag = tag
  end

  def name_display
    "#{@name} is a: #{@tag}"
  end
end
