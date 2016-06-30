require 'fiber'

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
    #
    # @param source [Enumerable]
    # @param pipe [#call]
    class Step
      def initialize(source, pipe=nil)
        @context = Fiber.new do
          source.each do |element|
            if pipe
              pipe.call(element)
            else
              Fiber.yield(element)
            end
          end
        end
      end

      # Loop through each value in the sequence, yielding control to the next
      # step if necessary.
      #
      # If a block is provided, it is called with the value. Otherwise, a lazy
      # enumerator representing the wrapped source is returned.
      def each
        return to_enum unless block_given?

        loop do
          element = @context.resume
          if @context.alive?
            yield element
          else
            return
          end
        end
      end

      # Returns the first element in the sequence.
      def first
        to_enum.next
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
