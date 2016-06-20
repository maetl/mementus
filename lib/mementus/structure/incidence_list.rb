module Mementus
  module Structure
    class IncidenceList
      def initialize(is_directed=true)
        @outgoing = {}
        @incoming = {}
        @nodes = {}
        @edges = {}
        @is_directed = is_directed
      end

      def is_directed?
        @is_directed
      end

      def nodes_count
        @nodes.count
      end

      def edges_count
        @edges.count
      end

      def has_node?(node)
        @nodes.key?(node.id)
      end

      def has_edge?(edge)
        @edges.key?(edge.id)
      end

      def set_node(node)
        @nodes[node.id] = NodeProxy.new(node, self)
        @outgoing[node.id] ||= []
        @incoming[node.id] ||= []
      end

      def set_edge(edge)
        set_node(edge.from) unless has_node?(edge.from)
        set_node(edge.to) unless has_node?(edge.to)

        @edges[edge.id] = edge
        @outgoing[edge.from.id] << edge.to.id
        @incoming[edge.to.id] << edge.from.id
      end

      def edge(id)
        @edges[id]
      end

      def node(id)
        @nodes[id]
      end

      def each_node(&block)
        @nodes.values.each(&block)
      end

      def nodes
        @nodes.values
      end

      def adjacent(id)
        @nodes.values_at(*@outgoing[id])
      end

      def each_adjacent(id, &blk)
        adjacent(id).each(&blk)
      end
    end
  end
end
