$LOAD_PATH.unshift('../../lib') unless $LOAD_PATH.include?('../../lib')
require 'input_parser'
input_parser = InputParser.new

class Rucksack
  attr_reader :compartment_one, :compartment_two

  def initialize(contents)
    split_point = contents.length / 2
    @compartment_one = contents[0..split_point-1]
    @compartment_two = contents[split_point..contents.length]
  end

  def unique_entries
    compartment_one.split('').uniq.each_with_object([]) do |character, entries|
      next unless compartment_two.include?(character)

      entries << character
    end
  end
end

class GroupedRucksack
  def initialize
    @rucksacks = []
  end

  def add_rucksack(rucksack)
    @rucksacks << rucksack
  end

  def unique_entry
    @rucksacks[0].split('').uniq.each do |char|
      if @rucksacks[1].include?(char) && @rucksacks[2].include?(char)
        return char
      end
    end
  end
end

priorities = {}
('a'..'z').each_with_index do |character, index|
 priorities[character] = index + 1
 priorities[character.upcase] = index + 27
end
unique_entries = []

if input_parser.day1?
  input_parser.lines.each do |line|
    rucksack = Rucksack.new(line)
    unique_entries += rucksack.unique_entries
  end
else
  grouped_rucksack = GroupedRucksack.new
  input_parser.lines.each_with_index do |line, index|
    grouped_rucksack.add_rucksack(line)
    next unless (index + 1) % 3 == 0

    unique_entries << grouped_rucksack.unique_entry
    grouped_rucksack = GroupedRucksack.new
  end
end

sum = 0
unique_entries.each do |unique_entry|
  sum += priorities[unique_entry]
end

puts "Sum: #{sum}"
