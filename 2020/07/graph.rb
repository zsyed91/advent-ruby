require_relative 'graph_node'
require_relative 'graph_edge'

class Graph
  attr_reader :nodes

  def initialize
    @nodes = {}
  end

  def add_node(node)
    @nodes[node.color] = node
  end

  def fetch_or_create(color)
    if @nodes.key?(color)
      @nodes[color]
    else
      @nodes[color] = GraphNode.new(color)
    end
  end
end
