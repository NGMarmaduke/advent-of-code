#!/usr/bin/env ruby
# http://adventofcode.com/2017/day/3

input = 368078

Point = Struct.new(:n, :x, :y) do
  def coord
    [x, y]
  end
end

def next_cords(x, y, orientation:)
  case orientation
  when :right
    [x + 1, y]
  when :up
    [x, y + 1]
  when :left
    [x - 1, y]
  when :down
    [x, y - 1]
  end
end

NEXT_ORIENTATION = { right: :up, up: :left, left: :down, down: :right }.freeze

spiral = Enumerator.new do |points|
  steps = Enumerator.new do |step|
    length = 1
    loop do
      2.times do
        step << length
      end
      length += 1
    end
  end

  x = 0
  y = 0
  n = 1
  orientation = :right

  points << Point.new(n, x, y)
  loop do
    next_step = steps.next

    next_step.times do
      n += 1
      x, y = next_cords(x, y, orientation: orientation)
      points << Point.new(n, x, y)
    end

    orientation = NEXT_ORIENTATION[orientation]
  end
end

target = spiral.take(input).last
puts "part one: #{target.x.abs + target.y.abs}"

# PART TWO

centre = Point.new(1, 0, 0)
grid = { centre.coord => centre }

part_two = spiral.lazy.map { |point|
  sum = 0
  [-1, 0, 1].each do |x|
    [-1, 0, 1].each do |y|
      adjacent = grid[[point.x + x, point.y + y]]
      sum += adjacent.n if adjacent
    end
  end

  point.n = sum
  grid[point.coord] = point
}.find { |point| point.n > input }

puts "part two: #{part_two.n}"
