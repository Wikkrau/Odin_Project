class Board
  attr_reader :grid  

  def initialize
    @grid = Array.new(3) { Array.new(3, ' ') }
  end

  def display
    @grid.each do |row|
      puts row.join(" | ")
      puts "-" * 9
    end
  end

  def clear
    @grid = Array.new(3) { Array.new(3, ' ') }
  end
end
