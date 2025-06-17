# frozen_string_literal: true

class Player
  def initialize(name, health, damage)
    @name = name
    @health = health
    @damage = damage
  end

  def check_health
    puts "#{@name} has #{@health} health left."
  end
end

require 'colorize'

puts 'Red goes faster!'.colorize(:red)

puts "I'm blue da ba dee da ba di!".colorize(:blue)

puts "It ain't easy bein' green...".colorize(:green)
