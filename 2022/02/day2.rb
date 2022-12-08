$LOAD_PATH.unshift('../../lib') unless $LOAD_PATH.include?('../../lib')
require 'input_parser'
input_parser = InputParser.new

SCORE_LOST = 0
SCORE_TIE = 3
SCORE_WON = 6

SCORE_ROCK = 1
SCORE_PAPER = 2
SCORE_SCISSORS = 3

OPPONENT_ROCK = 'A'
OPPONENT_PAPER = 'B'
OPPONENT_SCISSORS = 'C'

ROCK = 'X'
PAPER = 'Y'
SCISSORS = 'Z'

GOAL_LOSE = 'X'
GOAL_TIE = 'Y'
GOAL_WIN = 'Z'

GOAL_MAPPING = {
  GOAL_LOSE => SCORE_LOST,
  GOAL_TIE => SCORE_TIE,
  GOAL_WIN=> SCORE_WON,
}

SCORES = {
  OPPONENT_ROCK => {
    ROCK => SCORE_TIE,
    PAPER => SCORE_WON,
    SCISSORS => SCORE_LOST,
  },
  OPPONENT_PAPER => {
    ROCK => SCORE_LOST,
    PAPER => SCORE_TIE,
    SCISSORS => SCORE_WON,
  },
  OPPONENT_SCISSORS => {
    ROCK => SCORE_WON,
    PAPER => SCORE_LOST,
    SCISSORS => SCORE_TIE,
  },
}

def parse_line(line)
  columns = line.split(/\s/)

  {
    opponent: columns[0].upcase,
    my_move: columns[1].upcase,
  }
end

def calculate_move_score(my_move)
  if my_move == ROCK
    SCORE_ROCK
  elsif my_move == PAPER
    SCORE_PAPER
  elsif my_move == SCISSORS
    SCORE_SCISSORS
  else
    raise "Unknown move #{my_move}"
  end
end

def validate_opponent_move!(opponent)
  raise "Unknown opponent move #{opponent}" unless %w[A B C].include?(opponent)
end

def validate_my_move!(my_move)
  raise "Unknown move #{my_move}" unless %w[X Y Z].include?(my_move)
end

def calculate_score(opponent, my_move)
  validate_opponent_move!(opponent)
  validate_my_move!(my_move)

  SCORES[opponent][my_move] + calculate_move_score(my_move)
end

total_score = 0
input_parser.lines.each do |line|
  strategy = parse_line(line)

  if input_parser.day1?
    total_score += calculate_score(strategy[:opponent], strategy[:my_move])
  else
    goal_score = GOAL_MAPPING[strategy[:my_move]]
    my_move = SCORES[strategy[:opponent]].find { |key, value| value == goal_score }[0]
    total_score += calculate_score(strategy[:opponent], my_move)
  end
end

puts total_score
