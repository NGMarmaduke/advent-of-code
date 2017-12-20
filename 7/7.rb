#!/usr/bin/env ruby
# http://adventofcode.com/2017/day/7

program_mapping = File.open('input.txt').to_a

class Program
  MAPPING_PARSER = /^(?<name>\w+) \((?<weight>\d+)\)( -> (?<children>.*))?/

  attr_reader :name, :children_strs, :children
  attr_accessor :parents

  def initialize(mapping)
    mapped = mapping.match(MAPPING_PARSER)
    @name = mapped[:name]
    @weight = mapped[:weight].to_i
    @children_strs = mapped[:children] ? mapped[:children].split(', ') : []
    @parents = []
  end

  def link(all_programs)
    @children = children_strs.map do |child_name|
      child = all_programs.find { |program| program.name == child_name }
      child.parents << self
      child
    end
  end

  def weight
    @weight + children.map(&:weight).inject(0, :+)
  end

  def valid?
    children_weights = children.map(&:weight)
    children_weights.all? { |weight| weight == children_weights.first }
  end

  def print
    return if valid?
    puts '=' * 20
    puts "#{name}:#{weight}:#{valid?}"
    puts "children: #{children.map { |c| "#{c.name}:#{c.weight}" }}"

    children.each(&:print)
  end
end

programs = program_mapping.map { |mapping| Program.new(mapping.chomp) }
programs.each { |program| program.link(programs) }

root = programs.find { |program| program.parents.length == 0 }
puts "part one: #{root.name}"

root.print # find the node for part 2
