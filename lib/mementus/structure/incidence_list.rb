module Mementus
  module Structure
    class IncidenceList
      def initialize(is_directed=true)
        @outgoing = {}
        @incoming = {}
        @outgoing_e = {}
        @incoming_e = {}
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
        @outgoing_e[node.id] ||= []
        @incoming_e[node.id] ||= []
      end

      def set_edge(edge)
        set_node(edge.from) unless has_node?(edge.from)
        set_node(edge.to) unless has_node?(edge.to)

        @edges[edge.id] = EdgeProxy.new(edge, self)
        @outgoing[edge.from.id] << edge.to.id
        @incoming[edge.to.id] << edge.from.id
        @outgoing_e[edge.from.id] << edge.id
        @incoming_e[edge.to.id] << edge.id
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

      def nodes(match=nil)
        return @nodes.values unless match

        if match.is_a?(Hash)
          @nodes.values.select do |node|
            key = match.first.first
            val = match.first.last
            node[key] == val
          end
        elsif match.is_a?(Symbol)
          @nodes.values.select do |node|
            node.label == match
          end
        end
      end

      def edges(match=nil)
        return @edges.values unless match

        if match.is_a?(Hash)
          @edges.values.select do |edge|
            key = match.first.first
            val = match.first.last
            edge[key] == val
          end
        elsif match.is_a?(Symbol)
          @edges.values.select do |edge|
            edge.label == match
          end
        end
      end

      def adjacent(id, match=nil)
        return @nodes.values_at(*@outgoing[id]) unless match

        if match.is_a?(Hash)
          @nodes.values_at(*@outgoing[id]).select do |node|
            key = match.first.first
            val = match.first.last
            node[key] == val
          end
        elsif match.is_a?(Symbol)
          @nodes.values_at(*@outgoing[id]).select do |node|
            node.label == match
          end
        end
      end

      def each_adjacent(id, &blk)
        adjacent(id).each(&blk)
      end

      def adjacent_edges(id, match=nil)
        return @edges.values_at(*@outgoing_e[id]) unless match

        if match.is_a?(Hash)
          @edges.values_at(*@outgoing_e[id]).select do |edge|
            key = match.first.first
            val = match.first.last
            edge[key] == val
          end
        elsif match.is_a?(Symbol)
          @edges.values_at(*@outgoing_e[id]).select do |edge|
            edge.label == match
          end
        end
      end
    end
  end
end
