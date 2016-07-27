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

    def [](prop)
      @node[prop]
    end

    def props
      @node.props
    end

    def out_e
      Pipeline::Step.new(adjacent_edges, Pipeline::Pipe.new(@graph), @graph)
    end

    def each_adjacent(&block)
      @graph.each_adjacent(@node.id, &block)
    end

    def adjacent
      @graph.adjacent(@node.id)
    end

    def adjacent_edges
      @graph.adjacent_edges(@node.id)
    end
  end
end
