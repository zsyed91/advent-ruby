class InputParser
  attr_reader :input_file

  def initialize
    @input_file = "day#{ARGV[0]}.txt"
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

  def raw_lines
    File.readlines(input_file).map(&:chomp)
  end

  def lines(remove_empty_lines: true)
    remove_empty_lines ? raw_lines.reject(&:empty?) : raw_lines
  end
end
