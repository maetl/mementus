module Mementus
  module Pipeline
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
      # @param pipe [Mementus::Pipeline::Pipe]
      def initialize(source, pipe=nil, graph=nil)
        @source = source
        @pipe = pipe || Pipe.new(graph)
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
      def out(match=nil)
        outgoing_nodes = source.inject([]) do |result, node|
          result.concat(node.outgoing(match))
        end

        Step.new(outgoing_nodes, Pipe.new(graph), graph)
      end

      # Traverse to the incoming nodes pointing to the source elements.
      def in(match=nil)
        incoming_nodes = source.inject([]) do |result, node|
          result.concat(node.incoming(match))
        end

        Step.new(incoming_nodes, Pipe.new(graph), graph)
      end

      # Traverse to the outgoing edges from the source elements.
      def out_e(match=nil)
        outgoing_edges = source.inject([]) do |result, node|
          result.concat(graph.outgoing_edges(node.id, match))
        end

        Step.new(outgoing_edges, Pipe.new(graph), graph)
      end

      # Traverse to the incoming edges pointing to the source elements.
      def in_e(match=nil)
        incoming_edges = source.inject([]) do |result, node|
          result.concat(graph.incoming_edges(node.id, match))
        end

        Step.new(incoming_edges, Pipe.new(graph), graph)
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

      def depth_first(method=:out)
        Step.new(DepthFirstSearch.new(graph, source.first.id, method))
      end

      def breadth_first(method=:out)
        Step.new(BreadthFirstSearch.new(graph, source.first.id, method))
      end
    end
  end
end
