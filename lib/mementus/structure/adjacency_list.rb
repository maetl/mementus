module Mementus
  module Structure
    class AdjacencyList
      def initialize(is_directed=true)
        @index = {}
        @is_directed = is_directed
      end

      def nodes_count
        @index.size
      end

      def edges_count
        c = 0
        each_edge { c += 1 }
        c
      end

      def directed?
        @is_directed
      end

      def set_node(node)
        @index[node.id] ||= Set.new
      end

      def set_edge(edge)
        set_node(edge.from) unless has_node?(edge.from.id)
        set_node(edge.to) unless has_node?(edge.to.id)

        @index[edge.from.id].add(edge.to.id)
        @index[edge.to.id].add(edge.from.id) unless directed?
      end

      def has_node?(node)
        if node.is_a?(Mementus::Node) || node.is_a?(Mementus::NodeProxy)
          @index.key?(node.id)
        else
          @index.key?(node)
        end
      end

      def has_edge?(edge)
        if edge.is_a?(Mementus::Edge) || edge.is_a?(Mementus::EdgeProxy)
          has_node?(edge.from.id) && @index[edge.from.id].include?(edge.to.id)
        else
          raise 'Edge IDs are not supported by this data structure'
        end
      end

      def node(id)
        NodeProxy.new(Node.new(id: id), self)
      end

      def nodes
        @index.keys.map { |id| NodeProxy.new(Node.new(id: id), self) }
      end

      def adjacent(id)
        @index[id].to_a
      end

      def each_edge(&blk)
        if directed?
          nodes.each do |from|
            adjacent(from.id).each do |to|
              yield EdgeProxy.new(Edge.new(from: from, to: to), self)
            end
          end
        else
          raise 'Edge traversal unsupported for undirected graphs'
        end
      end
    end
  end
end
