module Mementus
  class Structure
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

    def create_edge(&block)
      edge = Edge.new
      yield edge
      add_edge(edge)
    end

    def add_node(node)
      @index[node] ||= Set.new
    end

    def create_node(&block)
      node = Node.new
      yield node
      add_node(node)
    end

    def add_edge(edge)
      add_node(edge.from) unless has_node?(edge.from)
      add_node(edge.to) unless has_node?(edge.to)

      @index[edge.from].add(edge.to)
      @index[edge.to].add(edge.from) unless directed?
    end

    def has_node?(node)
      @index.key?(node)
    end

    def has_edge?(edge)
      has_node?(edge.from) && @index[edge.from].include?(edge.to)
    end

    def node(id)
      @index.keys.find { |node| node.id == id }
    end

    def nodes
      @index.keys
    end

    def each_node(&blk)
      @index.each_key(&blk)
    end

    def each_adjacent(node, &blk)
      @index[node].each(&blk)
    end

    def each_edge(&blk)
      if directed?
        each_node do |from|
          each_adjacent(from) do |to|
            yield Edge.new(from, to)
          end
        end
      else
        raise 'Edge traversal unsupported for undirected graphs'
      end
    end
  end
end
