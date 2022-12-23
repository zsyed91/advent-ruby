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

priorities = {}
('a'..'z').each_with_index do |character, index|
 priorities[character] = index + 1
 priorities[character.upcase] = index + 27
end

unique_entries = []
input_parser.lines.each do |line|
  rucksack = Rucksack.new(line)

  unique_entries += rucksack.unique_entries
end

sum = 0
unique_entries.each do |unique_entry|
  sum += priorities[unique_entry]
end

puts sum
