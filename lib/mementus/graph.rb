require 'set'

module Mementus
  class Graph
    def initialize(is_directed=true)
      @structure = Structure.new(is_directed)
    end

    def query
      Query::Source.new(self)
    end

    def nodes_count
      @structure.nodes_count
    end

    def edges_count
      @structure.edges_count
    end

    def directed?
      @structure.directed?
    end

    def add_node(node)
      @structure.add_node(node)
    end

    def create_edge(&block)
      @structure.create_edge(&block)
    end

    def create_node(&block)
      @structure.create_node(&block)
    end

    def add_edge(edge)
      @structure.add_edge(edge)
    end

    def has_node?(node)
      @structure.has_node?(node)
    end

    def has_edge?(edge)
      @structure.has_edge?(edge)
    end

    def node(id)
      @structure.node(id)
    end

    def nodes
      @structure.nodes
    end

    def each_node(&blk)
      @structure.each_node(&blk)
    end

    def each_adjacent(node, &blk)
      @structure.each_adjacent(node, &blk)
    end

    def each_edge(&blk)
      @structure.each_edge(&blk)
    end
  end
end
