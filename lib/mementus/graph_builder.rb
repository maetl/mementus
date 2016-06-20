module Mementus
  class GraphBuilder
    def initialize(is_directed)
      @structure = Structure::IncidenceList.new(is_directed)
      @node_ids = IntegerId.new
      @edge_ids = IntegerId.new
    end

    def add_node(node)
      @structure.set_node(node)
    end

    def add_edge(edge)
      @structure.set_edge(edge)
    end

    def create_node(&block)
      builder = NodeBuilder.new
      yield builder
      builder.id = @node_ids.next_id unless builder.id
      add_node(builder.to_node)
    end

    def create_edge(&block)
      builder = EdgeBuilder.new
      yield builder
      builder.id = @edge_ids.next_id unless builder.id
      add_edge(builder.to_edge)
    end

    def graph
      @structure
    end
  end
end
