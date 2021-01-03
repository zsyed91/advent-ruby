class Instruction
  attr_accessor :operation
  attr_reader :argument

  NOP = 'nop'
  ACC = 'acc'
  JMP = 'jmp'

  def initialize(operation, argument)
    @operation = operation
    @argument = argument.to_i
  end
end
