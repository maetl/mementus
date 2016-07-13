require 'fiber'

module Mementus
  module Pipeline
    class Pipe
      # Basic passthrough.
      def call(element)
        Fiber.yield(element)
      end
    end

    # Represents a step in a pipeline chain.
    #
    # New steps are constructed from a `source` enumerable (usually the previous
    # step in the chain) and an optional `pipe` which provides the strategy
    # for generating output values.
    #
    # Each step has an internal `Fiber` context which is used to yield control
    # to the next step in the chain on each value in the iteration, rather than
    # cycle through the entire list of values before forwarding control.
    #
    # This avoids the problem of iterating over a huge set of nodes and edges
    # which are then discarded by a later step.
    #
    # The approach here is roughly similar to the way that Ruby chains together
    # `Enumerator::Lazy` objects.
    class Step
      # Initialize a pipeline step from the given source.
      #
      # @param source [#each]
      # @param pipe [#call]
      def initialize(source, pipe=Pipe.new, graph=nil)
        @source = source
        @pipe = pipe
        @graph = graph
      end

      attr_reader :source, :pipe, :graph
      private :source, :pipe, :graph

      # Loop through each value in the sequence, yielding control to the next
      # step if necessary.
      #
      # If a block is provided, it is called with the value. Otherwise, a lazy
      # enumerator representing the wrapped source is returned.
      def each
        return to_enum unless block_given?

        context = Fiber.new do
          source.each do |element|
            pipe.call(element)
          end

          raise StopIteration
        end

        loop do
          yield context.resume
        end
      end

      # Dereference ids from the source elements.
      def id
        ids = to_enum.map { |element| element.id }
        return ids.first if ids.length == 1
        ids
      end

      # Traverse to the outgoing nodes adjacent to the source elements.
      def out
        outgoing_nodes = source.inject([]) do |result, node|
          result.concat(node.adjacent)
        end

        Step.new(outgoing_nodes)
      end

      # Traverse to the incoming nodes pointing to the source elements.
      def in
        incoming_nodes = []

        source.each do |node|
          graph.each_node do |graph_node|
            graph.each_adjacent(graph_node.id) do |adj_node|
              incoming_nodes << graph_node if adj_node.id == node.id
            end
          end
        end

        Step.new(incoming_nodes)
      end

      # Traverse to the outgoing edges from the source elements.
      def out_e
        outgoing_edges = []

        source.each do |node|
          outgoing_edges = graph.each_adjacent(node.id).map do |id|
            Mementus::Edge.new(from: node, to: id)
          end
        end

        Step.new(outgoing_edges)
      end

      # Traverse to the incoming edges pointing to the source elements.
      def in_e
        ids = source.map(&:id)
        incoming_edges = []

        graph.each_node do |graph_node|
          graph.each_adjacent(graph_node.id) do |adj_node|
            incoming_edges << Mementus::Edge.new(from: graph_node, to: adj_node) if ids.include?(adj_node.id)
          end
        end

        Step.new(incoming_edges)
      end

      # Returns the first value in the sequence.
      def first
        to_enum.first
      end

      # Returns all values in the sequence
      def all
        to_enum.to_a
      end

      # Returns the given number of values from the sequence.
      def take(num)
        to_enum.take(num)
      end
    end
  end
end
