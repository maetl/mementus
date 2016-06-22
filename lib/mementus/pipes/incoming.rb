module Mementus
  module Pipes
    class Incoming
      def process(graph, node)
        incoming = []

        graph.each_node do |graph_node|
          graph.each_adjacent(graph_node.id) do |adj_node|
            incoming << graph_node if adj_node.id == node.id
          end
        end

        incoming
      end
    end
  end
end
