#!/usr/bin/env ruby
# http://adventofcode.com/2017/day/8
INSTRUCTION_REGEX = /(?<register>.*) (?<operation>inc|dec) (?<value>.*) if (?<comp_register>.*) (?<comp_operator>>|>=|!=|==|<|<=) (?<comp_value>.*)/

instructions = File.open('input.txt').map(&:chomp)
registers = Hash.new(0)
largest_register = 0

instructions.each do |instruction|
  match_data = instruction.match(INSTRUCTION_REGEX)
  comp_register = registers[match_data[:comp_register]]

  next unless comp_register.send(
    match_data[:comp_operator],
    match_data[:comp_value].to_i
  )

  if match_data[:operation] == 'inc'
    registers[match_data[:register]] += match_data[:value].to_i
  else
    registers[match_data[:register]] -= match_data[:value].to_i
  end

  if registers[match_data[:register]] > largest_register
    largest_register = registers[match_data[:register]]
  end
end

puts "part one: #{registers.values.sort.last}"
puts "part two: #{largest_register}"
