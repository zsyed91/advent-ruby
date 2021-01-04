$LOAD_PATH.unshift('../lib') unless $LOAD_PATH.include?('../lib')
require 'input_parser'
input_parser = InputParser.new

class Validator
  def initialize(numbers, preamble_size)
    @numbers = numbers
    @preamble_size = preamble_size
  end

  def find_first_invalid_number
    (@preamble_size..@numbers.size - 1).each do |index|
      return @numbers[index] unless sum_exists?(@numbers[index], index)
    end
  end

  def find_sequence_sum(number)
    sub_list = @numbers.drop_while { |number| number != number }[1..]

    (0..sub_list.size - 2).each do |first_index|
      numbers = [sub_list[first_index]]
      sum = sub_list[first_index]


      (first_index + 1..sub_list.size - 1).each do |second_index|
        sum += sub_list[second_index]
        numbers << sub_list[second_index]

        return numbers if sum == number
      end
    end

    []
  end

  private

  def sum_exists?(number, index)
    left_boundary = index - @preamble_size
    (left_boundary..index - 2).each do |first_index|
      (first_index + 1..index - 1).each do |second_index|
        sum = @numbers[first_index] + @numbers[second_index]

        return true if sum == number
      end
    end

    false
  end
end

numbers = input_parser.lines.map(&:to_i)
validator = Validator.new(numbers, 25)

if input_parser.day1?
  puts validator.find_first_invalid_number
else
  invalid_number = validator.find_first_invalid_number
  sequence = validator.find_sequence_sum(invalid_number)

  puts sequence.min + sequence.max
end
