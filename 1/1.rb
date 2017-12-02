#!/usr/bin/env ruby
# http://adventofcode.com/2017/day/1

def sum_pairs(chars, interval:)
  chars.each_with_index.inject(0) do |sum, (char, i)|
    next_char = chars[(i + interval) % chars.length]
    char == next_char ? sum + char.to_i : sum
  end
end

chars = File.read('input.txt').chomp.chars
puts "part one: #{sum_pairs(chars, interval: 1)}"
puts "part two: #{sum_pairs(chars, interval: chars.length / 2)}"
