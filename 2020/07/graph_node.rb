class GraphNode
  attr_reader :color, :edges

def initialize(color)
    @color = color
    @edges = []
  end

  def add_edge(edge)
    @edges << edge
  end

  def sub_total
    weight = 0
    edges.each do |edge|
      weight += edge.count + (edge.count * edge.node.sub_total)
    end

    weight
  end
end
