module Mementus
  class NodeProxy
    def initialize(node, graph)
      @node = node
      @graph = graph
    end

    def id
      @node.id
    end

    def label
      @node.label
    end

    def props
      @node.props
    end

    def each_adjacent(&block)
      @graph.each_adjacent(@node.id, &block)
    end

    def adjacent
      @graph.adjacent(@node.id)
    end
  end
end
