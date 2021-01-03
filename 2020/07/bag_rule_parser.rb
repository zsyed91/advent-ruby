class BagRuleParser
  NO_SUB_BAGS = 'no other bags'

  def parse(line)
    rule_details = line.split(/\s?contain\s?/)
    sub_bags = rule_details[1].split(/,\s?/).map do |sub_bag|
      sub_bag.tr('.', '')
    end

    {
      bag_color: rule_details[0],
      sub_bags: parse_sub_bags(sub_bags)
    }
  end

  private

  def parse_sub_bags(sub_bags)
    sub_bags.each_with_index do |sub_bag, index|
      return [] if sub_bag == NO_SUB_BAGS

      matches = sub_bag.match(/^([\d]+)\s([a-z\s]+)\sbags?$/)

      sub_bags[index] = { count: matches[1], sub_bag: matches[2] + ' bags' }
    end
  end
end
