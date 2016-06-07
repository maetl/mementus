module Mementus
  module Structure
    class IncidenceList
      def initialize
        @outgoing = {}
        @incoming = {}
        @nodes = {}
        @edges = {}
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
        @edges.key?("#{edge.from.id},#{edge.to.id}")
      end

      def add_node(node)
        @nodes[node.id] = node
        @outgoing[node.id] ||= Set.new
        @incoming[node.id] ||= Set.new
      end

      def add_edge(edge)
        add_node(edge.from) unless has_node?(edge.from)
        add_node(edge.to) unless has_node?(edge.to)

        @edges["#{edge.from.id},#{edge.to.id}"] = edge
        @outgoing[edge.from.id].add(edge.to.id)
        @incoming[edge.to.id].add(edge.from.id)
      end

      def node(id)
        NodeProxy.new(id, self)
      end

      def nodes
        @nodes.keys.map { |id| NodeProxy.new(id, self) }
      end

      def adjacent(id)
        @outgoing[id].to_a
      end

      def each_adjacent(id, &blk)
        @outgoing[id].each(&blk)
      end
    end
  end
end
