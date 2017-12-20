#!/usr/bin/env ruby
# http://adventofcode.com/2017/day/9

input = File.read('input.txt')
input.gsub!(/!./, '')

score = 0
group_depth = 0
garbage = false
canceled_chars = 0

input.chars.each do |c|
  canceled_chars += 1 if garbage && c != '>'

  case c
  when '{'
    group_depth += 1 unless garbage
  when '}'
    unless garbage
      score += group_depth
      group_depth -= 1
    end
  when '<'
    garbage = true
  when '>'
    garbage = false
  end
end

puts "part one: #{score}"
puts "part two: #{canceled_chars}"
