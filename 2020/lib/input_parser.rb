class InputParser
  attr_reader :input_file

  def initialize
    @input_file = ARGV[0]
    @day = ARGV[1]

    raise 'Input file required!' if @input_file.nil?
  end

  def day
    day1? ? '1' : '2'
  end

  def day1?
    @day.nil? || @day == '1'
  end

  def day2?
    !day1?
  end

  def lines
    File.readlines(input_file).map(&:chomp).reject(&:empty?)
  end
end
