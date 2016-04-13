module Mementus
  module Query
    class Step
      def initialize(traversal, id)
        @node = NodeProxy.new(traversal.graph.node(id), traversal.graph)
      end

      def to_node
        @node
      end
    end
  end
end
