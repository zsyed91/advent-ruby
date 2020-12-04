class TargetNumberLocator
  attr_reader :numbers, :target_number

  def initialize(numbers, target_number)
    @numbers = numbers
    @target_number = target_number
  end

  # This is ugly but it works
  def find(number_of_matches)
    if number_of_matches == 2
      (0..numbers.length-1).each do |first_number|
        (first_number+1..numbers.length-1).each do |second_number|
          if match?(first_number, second_number)
            return calculate_answer(first_number, second_number)
          end
        end
      end
    elsif number_of_matches == 3
      (0..numbers.length-1).each do |first_number|
        (first_number+1..numbers.length-1).each do |second_number|
          (second_number+1..numbers.length-1).each do |third_number|
            if match?(first_number, second_number, third_number)
              return calculate_answer(first_number, second_number, third_number)
            end
          end
        end
      end
    end
  end

  private

  def calculate_sum(*indexes)
    indexes.inject(0) { |sum, index| sum + numbers[index] }
  end

  def calculate_answer(*indexes)
    indexes.inject(1) { |product, index| product * numbers[index] }
  end

  def match?(*indexes)
    calculate_sum(*indexes) == target_number
  end
end
