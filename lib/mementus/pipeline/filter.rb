module Mementus
  module Pipeline
    class Filter < Pipe
      def call(element)
        Fiber.yield(element) if process(element)
      end
    end
  end
end
