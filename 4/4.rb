#!/usr/bin/env ruby
# http://adventofcode.com/2017/day/4

# PART ONE

part_one = File.open('input.txt').inject(0) do |sum, line|
  words = line.split(' ')
  words.uniq == words ? sum + 1 : sum
end

puts "part one: #{part_one}"

# PART TWO

part_two = File.open('input.txt').inject(0) do |sum, line|
  words = line.split(' ').map{ |word| word.chars.sort.join }
  words.uniq == words ? sum + 1 : sum
end

puts "part two: #{part_two}"
