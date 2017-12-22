#!/usr/bin/env ruby
# http://adventofcode.com/2017/day/10

input = '46,41,212,83,1,255,157,65,139,52,39,254,2,86,0,204'

def knot(key, rounds: 1)
  current_position = 0
  skip_size = 0
  list = (0..255).to_a

  rounds.times do
    key.each do |length|
      list.rotate!(current_position)
      list[0...length] = list[0...length].reverse
      list.rotate!(-current_position)
      current_position += length + skip_size
      skip_size += 1
    end
  end

  list
end

def knot_hash(string)
  knot(
    string.bytes + [17, 31, 73, 47, 23],
    rounds: 64
  ).each_slice(16).map { |cons| format('%02x', cons.reduce(:^)) }.join
end

a, b = knot(input.split(',').map(&:to_i))
puts "part one: #{a * b}"

puts "part two: #{knot_hash(input)}"
