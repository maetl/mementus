module Mementus
  module Query
    class Step
      def initialize(traversal, id)
        @traversal = traversal
        @id = id
      end

      def to_node
        @traversal.graph.node(@id)
      end
    end
  end
end
