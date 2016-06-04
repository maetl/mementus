module Mementus
  class NodeProxy
    def initialize(id, graph)
      @id = id
      @graph = graph
    end

    def id
      @id
    end

    def each_adjacent(&block)
      @graph.each_adjacent(@id, &block)
    end

    def adjacent
      each_adjacent.to_a.map do |node|
        self.class.new(node, @graph)
      end
    end
  end
end
