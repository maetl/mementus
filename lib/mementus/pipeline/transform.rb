module Mementus
  module Pipeline
    class Transform < Pipe
      def call(element)
        Fiber.yield(process(element))
      end
    end
  end
end
