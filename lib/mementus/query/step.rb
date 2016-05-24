module Mementus
  module Query
    class Step
      def initialize(traversal, id)
        @node = NodeProxy.new(id, traversal.graph)
      end

      def to_node
        @node
      end
    end
  end
end
