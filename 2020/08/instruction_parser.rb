class InstructionParser
  def parse(line)
    results = line.split(/\s/)

    { operation: results[0], argument: results[1] }
  end
end
