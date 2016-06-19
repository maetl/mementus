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
      append_next(Pipes::Outgoing.new)
      self
    end

    def out_e
      append_next(Pipes::OutgoingEdges.new)
      self
    end

    def in
      append_next(Pipes::Incoming.new)
      self
    end

    def in_e
      append_next(Pipes::IncomingEdges.new)
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

    class Outgoing
      def process(graph, source)
        if source.respond_to?(:adjacent)
          source.adjacent
        else
          source.inject([]) do |result, node|
            result.concat(node.adjacent)
          end
        end
      end
    end

    class OutgoingEdges
      def process(graph, node)
        graph.each_adjacent(node.id).map do |id|
          Mementus::Edge.new(from: node, to: id)
        end
      end
    end

    class Incoming
      def process(graph, node)
        incoming = []

        graph.each_node do |graph_node|
          graph.each_adjacent(graph_node.id) do |adj_node|
            incoming << graph_node if adj_node.id == node.id
          end
        end

        incoming
      end
    end

    class IncomingEdges
      def process(graph, source)
        ids = source.respond_to?(:id) ? [source.id] : source.map(&:id)
        incoming = []

        graph.each_node do |graph_node|
          graph.each_adjacent(graph_node.id) do |adj_node|
            incoming << Mementus::Edge.new(from: graph_node, to: adj_node) if ids.include?(adj_node.id)
          end
        end

        incoming
      end
    end
  end
end
