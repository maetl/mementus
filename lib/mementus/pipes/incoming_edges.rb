module Mementus
  module Pipes
    class IncomingEdges
      def process(graph, source)
        ids = source.respond_to?(:id) ? [source.id] : source.map(&:id)
        incoming = []

        graph.each_node do |graph_node|
          graph.each_adjacent(graph_node.id) do |adj_node|
            incoming << Mementus::Edge.new(from: graph_node, to: adj_node) if ids.include?(adj_node.id)
          end
        end

        incoming
      end
    end
  end
end
