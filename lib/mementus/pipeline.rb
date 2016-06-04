module Mementus
  class Processor
    def initialize(graph, start_pipe)
      @graph = graph
      @pipeline = [start_pipe]
    end

    def append_next(pipe)
      @pipeline << pipe
    end

    def process
      output = nil
      @pipeline.each do |pipe|
        output = pipe.process(@graph, output)
      end
      output
    end

    def id
      process.id
    end

    def one
      output = process

      if output.respond_to?(:each)
        output.first
      else
        output
      end
    end

    def all
      process.to_a
    end

    def out
      append_next(Pipes::Out.new)
      self
    end
  end

  module Pipes
    class Node
      def initialize(id)
        @id = id
      end

      def process(graph, id)
        graph.node(id || @id)
      end
    end

    class Out
      def process(graph, node)
        graph.each_adjacent(node.id).map do |id|
          Mementus::NodeProxy.new(id, graph)
        end
      end
    end
  end
end
