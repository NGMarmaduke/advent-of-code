#!/usr/bin/env ruby
# http://adventofcode.com/2017/day/5

def break_free(part:)
  instructions = File.open('input.txt').map(&:strip).map(&:to_i)

  count = 0
  pointer = 0

  loop do
    instruction = instructions[pointer]

    if part == :one || instruction < 3
      instructions[pointer] += 1
    else
      instructions[pointer] -= 1
    end

    pointer += instruction
    count += 1
    break if pointer < 0 || pointer >= instructions.length
  end

  count
end

puts "part one: #{break_free(part: :one)}"
puts "part two: #{break_free(part: :two)}"
