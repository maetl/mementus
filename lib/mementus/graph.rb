module Mementus
  class Graph
    def initialize(is_mutable: false, is_directed: true, &block)
      builder = GraphBuilder.new(is_directed)

      BindingDelegator.new(builder, block.binding).instance_eval(&block) if block_given?

      @structure = builder.graph

      if is_mutable
        self.class.include Mutators
        @node_ids = IntegerId.new(builder.next_node_id)
        @edge_ids = IntegerId.new(builder.next_edge_id)
      end
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

    def has_edge?(edge, to=nil)
      @structure.has_edge?(edge, to)
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

    def edges(match=nil)
      @structure.edges(match)
    end

    def outgoing(id, match=nil)
      @structure.adjacent(id, match)
    end

    def incoming(id, match=nil)
      @structure.incoming(id, match)
    end

    def outgoing_edges(id, match=nil)
      @structure.outgoing_edges(id, match)
    end

    def incoming_edges(id, match=nil)
      @structure.incoming_edges(id, match)
    end

    def each_node(&blk)
      @structure.each_node(&blk)
    end

    def each_edge(&blk)
      @structure.each_edge(&blk)
    end
  end
end
