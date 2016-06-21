module Mementus
  class GraphBuilder
    def initialize(is_directed)
      @structure = Structure::IncidenceList.new(is_directed)
      @node_ids = IntegerId.new
      @edge_ids = IntegerId.new
    end

    def set_node(node)
      @structure.set_node(node)
    end

    def set_edge(edge)
      @structure.set_edge(edge)
    end

    def add_node(id: nil, label: nil, props: {})
      id = @node_ids.next_id unless id
      @structure.set_node(Node.new(id: id, label: label, props: props))
    end

    def add_edge(id: nil, from: nil, to: nil, label: nil, props: {})
      id = @edge_ids.next_id unless id
      @structure.set_edge(Edge.new(id: id, from: from, to: to, label: label, props: props))
    end

    def create_node(&block)
      builder = NodeBuilder.new
      yield builder
      builder.id = @node_ids.next_id unless builder.id
      set_node(builder.to_node)
    end

    def create_edge(&block)
      builder = EdgeBuilder.new
      yield builder
      builder.id = @edge_ids.next_id unless builder.id
      set_edge(builder.to_edge)
    end

    def graph
      @structure
    end
  end
end
