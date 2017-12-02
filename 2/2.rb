#!/usr/bin/env ruby
# http://adventofcode.com/2017/day/2

# PART ONE

part_one = File.open('input.txt').inject(0) do |sum, line|
  row = line.scan(/(\d+)/).flatten.map(&:to_i).sort
  sum + (row.last - row.first)
end

puts "part one: #{part_one}"

# PART TWO

def part_two_check_sum(row)
  row.each do |cell|
    row.each do |comp|
      next if cell == comp || cell < comp

      return cell / comp if (cell % comp).zero?
    end
  end
end

part_two = File.open('input.txt').inject(0) do |sum, line|
  row = line.scan(/(\d+)/).flatten.map(&:to_i)
  sum + part_two_check_sum(row)
end

puts "part two: #{part_two}"
