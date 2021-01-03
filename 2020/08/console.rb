class Console
  attr_reader :accumulator, :instructions, :pointer, :visited

  def initialize(instructions)
    @instructions = instructions
    initialize_defaults
  end

  def run
    initialize_defaults

    until loop? || end_of_instructions?
      instruction = instructions[pointer]
      update_visited

      case instruction.operation
      when Instruction::NOP
        @pointer += 1
      when Instruction::ACC
        @pointer += 1
        @accumulator += instruction.argument
      when Instruction::JMP
        @pointer += instruction.argument
      end
    end
  end

  def fix
    instructions.each do |instruction|
      next if instruction.operation == Instruction::ACC

      original_operation = instruction.operation
      flip_instruction(instruction)

      run

      # Check if we hit a loop and did not exit the program
      #   if we did not, then we have the fix so return here
      return unless loop? && !end_of_instructions?

      # reset the instruction so we can flip the next one and try again
      instruction.operation = original_operation
    end
  end

  private

  def flip_instruction(instruction)
    return if instruction.operation == Instruction::ACC

    if instruction.operation == Instruction::NOP
      instruction.operation = Instruction::JMP
    else
      instruction.operation = Instruction::NOP
    end
  end

  def initialize_defaults
    @accumulator = 0
    @pointer = 0
    @visited = {}
  end

  def update_visited
    @visited[pointer] ||= 0
    @visited[pointer] += 1
  end

  def loop?
    @visited.key?(pointer) && @visited[pointer] > 0
  end

  def end_of_instructions?
    instructions[pointer].nil?
  end
end
