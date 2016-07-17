module Mementus
  module Pipeline
    # Base class for pipes to inherit from.
    class Pipe
      def initialize(graph)
        @graph = graph
      end

      attr_reader :graph
      private :graph

      # Basic passthrough.
      def process(element)
        element
      end

      # Basic passthrough.
      def call(element)
        Fiber.yield(element)
      end
    end
  end
end
