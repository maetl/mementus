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

    def each_adjacent(&block)
      @graph.each_adjacent(@node, &block)
    end

    def adjacent
      each_adjacent.to_a.map do |node|
        self.class.new(node, @graph)
      end
    end
  end
end
