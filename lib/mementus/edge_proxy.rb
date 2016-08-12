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
      @edge.from
    end

    def to
      @edge.to
    end
  end
end
