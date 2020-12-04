require_relative 'target_number_locator'

input_file = ARGV[0]

raise 'input file required!' if input_file.nil?

number_of_matches = ARGV[1].nil? ? 2 : ARGV[1].to_i
target_number = ARGV[2].nil? ? 2020 : ARGV[2].to_i

numbers = []

File.readlines(input_file).each do |line|
  numbers << line.chomp.to_i
end

target_number_locator = TargetNumberLocator.new(numbers, target_number)
puts target_number_locator.find(number_of_matches)
