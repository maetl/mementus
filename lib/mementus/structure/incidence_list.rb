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
        if node.is_a?(Mementus::Node) || node.is_a?(Mementus::NodeProxy)
          @nodes.key?(node.id)
        else
          @nodes.key?(node)
        end
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
        set_node(edge.from) unless has_node?(edge.from.id)
        set_node(edge.to) unless has_node?(edge.to.id)

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

      def adjacent(id, match=nil, direction=:out)
        directional_index = case direction
        when :out then @outgoing
        when :in then @incoming
        end

        return @nodes.values_at(*directional_index[id]) unless match

        if match.is_a?(Hash)
          @nodes.values_at(*directional_index[id]).select do |node|
            key = match.first.first
            val = match.first.last
            node[key] == val
          end
        elsif match.is_a?(Symbol)
          @nodes.values_at(*directional_index[id]).select do |node|
            node.label == match
          end
        end
      end

      def outgoing(id, match=nil)
        adjacent(id, match, :out)
      end

      def incoming(id, match=nil)
        adjacent(id, match, :in)
      end

      def incident_edges(id, match=nil, direction=:out)
        directional_index = case direction
        when :out then @outgoing_e
        when :in then @incoming_e
        end

        return @edges.values_at(*directional_index[id]) unless match

        if match.is_a?(Hash)
          @edges.values_at(*directional_index[id]).select do |edge|
            key = match.first.first
            val = match.first.last
            edge[key] == val
          end
        elsif match.is_a?(Symbol)
          @edges.values_at(*directional_index[id]).select do |edge|
            edge.label == match
          end
        end
      end

      def outgoing_edges(id, match=nil)
        incident_edges(id, match, :out)
      end

      def incoming_edges(id, match=nil)
        incident_edges(id, match, :in)
      end
    end
  end
end
