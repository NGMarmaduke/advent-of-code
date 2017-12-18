#!/usr/bin/env ruby
# http://adventofcode.com/2017/day/6

banks = File.open('input.txt').first.chomp.split("\t").map(&:to_i)

class Memory
  attr_accessor :banks, :seen_banks

  def initialize(banks:)
    @banks = banks
    @seen_banks = [banks.dup]
  end

  def balance
    index = biggest_index
    blocks = banks[index]
    banks[index] = 0
    distribute_blocks(blocks, start_index: index)

    return seen_banks.length if seen_before?
    balance
  end

  private

  def distribute_blocks(blocks, start_index:)
    blocks.times do |i|
      next_index = (start_index + 1 + i) % banks.length
      banks[next_index] += 1
    end
  end

  def biggest_index
    largest_volume = banks.sort.last
    banks.find_index { |bank| bank == largest_volume }
  end

  def seen_before?
    return true if seen_banks.include?(banks)
    seen_banks << banks.dup
    false
  end
end

memory = Memory.new(banks: banks)
itteration_count = memory.balance
puts "part one: #{itteration_count}"

first_seen = memory.seen_banks.index(memory.banks)
puts "part two: #{itteration_count - first_seen}"
