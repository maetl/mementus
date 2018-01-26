module Mementus
  class NodeProxy
    def initialize(node, graph)
      @node = node
      @graph = graph
    end

    def id
      @node.id
    end

    def label
      @node.label
    end

    def [](prop)
      @node[prop]
    end

    def props
      @node.props
    end

    def out(match=nil)
      Pipeline::Step.new([self], Pipeline::Pipe.new(@graph), @graph).out(match)
    end

    def out_e(match=nil)
      Pipeline::Step.new([self], Pipeline::Pipe.new(@graph), @graph).out_e(match)
    end

    def in(match=nil)
      Pipeline::Step.new([self], Pipeline::Pipe.new(@graph), @graph).in(match)
    end

    def in_e(match=nil)
      Pipeline::Step.new([self], Pipeline::Pipe.new(@graph), @graph).in(match)
    end

    def each_adjacent(&block)
      @graph.each_adjacent(@node.id, &block)
    end

    def outgoing(match=nil)
      @graph.outgoing(@node.id, match)
    end

    def incoming(match=nil)
      @graph.incoming(@node.id, match)
    end

    def outgoing_edges(match=nil)
      @graph.outgoing_edges(@node.id, match)
    end

    def incoming_edges(match=nil)
      @graph.incoming_edges(@node.id, match)
    end
  end
end
