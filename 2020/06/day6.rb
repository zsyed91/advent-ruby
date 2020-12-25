$LOAD_PATH.unshift('../lib') unless $LOAD_PATH.include?('../lib')
require 'input_parser'
require_relative 'survey'

input_parser = InputParser.new
surveys = []

survey = Survey.new
input_parser.lines(remove_empty_lines: false).each do |line|
  if line.empty?
    surveys << survey
    survey = Survey.new
  else
    survey.add_member
    line.split('').each { |letter| survey.add_result(letter) }
  end
end

surveys << survey unless survey.nil?

if input_parser.day1?
  puts surveys.map(&:questionaire).map(&:size).reduce(&:+)
else
  all_yes_counts = 0
  surveys.each do |survey|
    survey.questionaire.values.each do |number_of_yes|
      all_yes_counts += 1 if number_of_yes == survey.group_size
    end
  end

  puts all_yes_counts
end
