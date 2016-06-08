module Mementus
  class GraphBuilder
    def initialize(is_directed)
      @structure = Structure::IncidenceList.new(is_directed)
    end

    def add_node(node)
      @structure.add_node(node)
    end

    def create_edge(&block)
      edge = EdgeBuilder.new
      yield edge
      @structure.add_edge(edge)
    end

    def create_node(&block)
      node = NodeBuilder.new
      yield node
      @structure.add_node(node)
    end

    def add_edge(edge)
      @structure.add_edge(edge)
    end

    def graph
      @structure
    end
  end
end
