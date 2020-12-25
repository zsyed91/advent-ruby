class Survey
  attr_reader :questionaire, :group_size

  def initialize
    @group_size = 0
    @questionaire = {}
  end

  def add_member
    @group_size += 1
  end

  def add_result(letter)
    @questionaire[letter] ||= 0
    @questionaire[letter] += 1
  end
end
