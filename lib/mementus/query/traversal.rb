module Mementus
  module Query
    class Traversal
      attr_reader :graph

      def initialize(graph)
        @graph = graph
        @steps = []
      end

      def add_step(step)
        @steps << step
        self
      end

      def adjacent
        @steps.last.to_node.adjacent
      end

      def id
        @steps.last.to_node.id
      end
    end
  end
end
