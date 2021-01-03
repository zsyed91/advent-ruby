class GraphEdge
  attr_reader :node, :count

  def initialize(node, count)
    @node = node
    @count = count
  end
end
