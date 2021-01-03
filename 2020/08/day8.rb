$LOAD_PATH.unshift('../lib') unless $LOAD_PATH.include?('../lib')
require 'input_parser'

require_relative 'instruction_parser'
require_relative 'instruction'
require_relative 'console'

input_parser = InputParser.new
instruction_parser = InstructionParser.new
instructions = []

input_parser.lines.each do |line|
  instruction = instruction_parser.parse(line)

  instructions << Instruction.new(
    instruction[:operation], instruction[:argument]
  )
end

console = Console.new(instructions)

if input_parser.day1?
  console.run

  puts console.accumulator
else
  console.fix
  puts console.accumulator
end
