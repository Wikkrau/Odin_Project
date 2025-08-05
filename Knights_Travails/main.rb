require 'set'

class Knight
  attr_accessor :position, :parent

  def initialize(position, parent = nil) # in prev project position was value and parent was prev
    @position = position
    @parent = parent
  end

  def get_path # First in last out
    return [@position] unless @parent #  no parent empty path

    path = []
    current = self

    while current
      path.unshift(current.position)
      current = current.parent
    end

    path
  end
end

def knight_moves(start, target)
  root = Knight.new(start) # Root has no parent (nil)
  queue = [root]
  visited = Set.new([start])

  moves = [
    [2, 1], [1, 2], [-1, 2], [-2, 1],
    [-2, -1], [-1, -2], [1, -2], [2, -1]
  ]

  def valid_position?(x, y, visited)
    x >= 0 && y >= 0 && x < 8 && y < 8 && !visited.include?([x, y])
  end

  until queue.empty?
    current_knight = queue.shift
    x, y = current_knight.position

    if current_knight.position == target
      path = current_knight.get_path
      chess_path = convert_to_chess(path) # ← Convert only for display
      puts "You made it in #{chess_path.length - 1} moves! Here's your path:"
      chess_path.each { |pos| puts pos }
      return path
    end

    moves.each do |dx, dy|
      nx = x + dx
      ny = y + dy

      next unless valid_position?(nx, ny, visited)

      visited << [nx, ny]
      child_knight = Knight.new([nx, ny], current_knight)
      queue << child_knight
    end
  end
end

def convert_to_chess(path)
  path.map do |pos|
    x, y = pos
    col = ('a'.ord + y).chr  # 0='a', 1='b', etc.
    row = (x + 1).to_s       # 0='1', 1='2', etc.
    "#{col}#{row}"
  end
end

start = [0, 0]
target = [2, 2]
knight_moves(start, target)
