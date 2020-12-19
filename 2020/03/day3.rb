require_relative 'slope'
require_relative 'coordinate'
require_relative 'forest'

input_file = ARGV[0]
day = ARGV[1] || '1'

raise 'input file required!' if input_file.nil?

forest = Forest.new

File.readlines(input_file).each do |line|
  forest.build_map(line.chomp)
end

if day == '1'
  puts forest.traverse(3)
else
  slopes = [1, 3, 5, 7, 0.5]

  tree_counts = slopes.each_with_object([]) do |slope, trees|
    trees << forest.traverse(slope)
  end

  puts tree_counts.reduce(&:*)
end
