require 'set'

module Mementus
  class Graph
    def initialize(is_directed=true, &block)
      builder = GraphBuilder.new(is_directed)

      builder.instance_eval(&block) if block_given?

      @structure = builder.graph
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

    def n(match)
      if match.is_a?(Hash) || match.is_a?(Symbol)
        source = nodes(match)
      else
        source = [node(match)]
      end

      Pipeline::Step.new(source, Pipeline::Pipe.new(self), self)
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

    def edge(id)
      @structure.edge(id)
    end

    def nodes(match=nil)
      @structure.nodes(match)
    end

    def adjacent(id)
      @structure.adjacent(id)
    end

    def adjacent_edges(id)
      @structure.adjacent_edges(id)
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
