module Mementus
  module Pipes
    class Node
      def initialize(id)
        @id = id
      end

      def process(graph, id)
        graph.node(id || @id)
      end
    end
  end
end
