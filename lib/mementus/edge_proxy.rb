module Mementus
  class EdgeProxy
    def initialize(edge, graph)
      @edge = edge
      @graph = graph
    end

    def id
      @edge.id
    end

    def label
      @edge.label
    end

    def [](prop)
      @edge[prop]
    end

    def props
      @edge.props
    end

    def from
      @graph.node(@edge.from.id)
    end

    def to
      @graph.node(@edge.to.id)
    end
  end
end
