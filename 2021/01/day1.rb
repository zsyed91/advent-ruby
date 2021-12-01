$LOAD_PATH.unshift('../lib') unless $LOAD_PATH.include?('../lib')
require 'input_parser'
input_parser = InputParser.new

elevations = input_parser.lines.map(&:to_i)

directions = {
  increasing: 0,
  decreasing: 0
}

elevations.each_with_index do |current_elevation, index|
  next if index.zero?

  previous_elevation = elevations[index - 1]

  elevation_difference = current_elevation - previous_elevation

  if elevation_difference.positive?
    directions[:increasing] += 1
  elsif elevation_difference.negative?
    directions[:decreasing] += 1
  end
end

puts directions[:increasing]

