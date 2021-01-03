$LOAD_PATH.unshift('../lib') unless $LOAD_PATH.include?('../lib')
require 'input_parser'
require_relative 'bag_rule_parser'
require_relative 'graph'

input_parser = InputParser.new
bag_rule_parser = BagRuleParser.new

graph = Graph.new

input_parser.lines.each do |line|
  results = bag_rule_parser.parse(line)

  bag_color = results[:bag_color]
  sub_bags = results[:sub_bags]

  node = graph.fetch_or_create(bag_color)

  sub_bags.each do |sub_bag|
    sub_node = graph.fetch_or_create(sub_bag[:sub_bag])
    weight = sub_bag[:count].to_i
    edge = GraphEdge.new(sub_node, weight)
    node.add_edge(edge)
  end
end

paths = 0
desired_bag_color = 'shiny gold bags'

if input_parser.day1?

  graph.nodes.values.each do |node|
    next if node.color == desired_bag_color

    queue = []
    visited = []
    node.edges.each do |edge|
      if edge.node.color == desired_bag_color
        paths += 1
        queue = []
        visited = []
        break
      else
        queue << edge.node
      end
    end

    until queue.empty?
      sub_node = queue.pop

      if sub_node.color == desired_bag_color
        paths += 1
        queue = []
        visited = []
        break
      else
        sub_node.edges.each do |edge|
          next if visited.include?(edge.node)

          visited << edge.node
          queue << edge.node
        end
      end
    end
  end

  puts paths

else
  root_node = graph.nodes[desired_bag_color]
  cost = 0

  root_node.edges.each do |edge|
    cost += edge.count + (edge.count * edge.node.sub_total)
  end

  puts cost
end
