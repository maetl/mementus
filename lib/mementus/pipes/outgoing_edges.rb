module Mementus
  module Pipes
    class OutgoingEdges
      def process(node)
        @graph.each_adjacent(node.id).map do |id|
          Mementus::Edge.new(from: node, to: id)
        end
      end
    end
  end
end
