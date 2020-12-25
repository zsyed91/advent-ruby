$LOAD_PATH.unshift('../lib') unless $LOAD_PATH.include?('../lib')
require 'input_parser'
require_relative 'boarding_pass'
require_relative 'boarding_pass_parser'

def consecutive?(left_boarding_pass, right_boarding_pass)
  left_boarding_pass.seat_id + 1 == right_boarding_pass.seat_id
end

input_parser = InputParser.new
boarding_pass_parser = BoardingPassParser.new

boarding_passes = input_parser.lines.each_with_object([]) do |code, passes|
  passes << BoardingPass.new(boarding_pass_parser.decode(code))
end

if input_parser.day1?
  puts boarding_passes.map(&:seat_id).max
else
  boarding_passes = boarding_passes.sort_by(&:seat_id)
  missing_boarding_pass = nil

  (1..boarding_passes.size-2).each do |index|
    left_boarding_pass = boarding_passes[index - 1]
    boarding_pass = boarding_passes[index]
    right_boarding_pass = boarding_passes[index + 1]

    if consecutive?(left_boarding_pass, boarding_pass) &&
      consecutive?(boarding_pass, right_boarding_pass)
      next
    elsif consecutive?(left_boarding_pass, boarding_pass)
      missing_boarding_pass = boarding_pass.seat_id + 1
    else
      missing_boarding_pass = boarding_pass.seat_id - 1
    end
  end

  puts missing_boarding_pass
end
