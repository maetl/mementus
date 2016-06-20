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
        set_node(edge.from) unless has_node?(edge.from)
        set_node(edge.to) unless has_node?(edge.to)

        @index[edge.from.id].add(edge.to.id)
        @index[edge.to.id].add(edge.from.id) unless directed?
      end

      def has_node?(node)
        @index.key?(node.id)
      end

      def has_edge?(edge)
        has_node?(edge.from) && @index[edge.from.id].include?(edge.to.id)
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

      def each_node(&blk)
        nodes.each(&blk)
      end

      def each_adjacent(id, &blk)
        @index[id].each(&blk)
      end

      def each_edge(&blk)
        if directed?
          each_node do |from|
            each_adjacent(from.id) do |to|
              yield Edge.new(from: from, to: to)
            end
          end
        else
          raise 'Edge traversal unsupported for undirected graphs'
        end
      end
    end
  end
end
