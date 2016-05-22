module Mementus
  class GraphBuilder
    def initialize(is_directed)
      @structure = Structure.new(is_directed)
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

    def graph
      @structure
    end
  end
end
