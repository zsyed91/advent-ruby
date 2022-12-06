$LOAD_PATH.unshift('../../lib') unless $LOAD_PATH.include?('../../lib')
require 'input_parser'
input_parser = InputParser.new

require "pry"

class CalorieCounter
  attr_reader :elf_id, :amount

  def initialize(elf_id)
    @elf_id = elf_id
    @amount = 0
  end

  def add(calories)
    @amount += calories
  end
end

@elves = []
id = 1
calory_counter = CalorieCounter.new(id)
input_parser.lines(remove_empty_lines: false).each do |calories|
  if calories.empty?
    @elves << calory_counter
    id += 1
    calory_counter = CalorieCounter.new(id)
    next
  end

  calory_counter.add(calories.to_i)
end

if input_parser.day1?
  puts @elves.sort_by(&:amount).last.amount
end
