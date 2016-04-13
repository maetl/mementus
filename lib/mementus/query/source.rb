module Mementus
  module Query
    class Source
      def initialize(graph)
        @traversal = Traversal.new(graph)
      end

      def node(id)
        @traversal.add_step(Step.new(@traversal, id))
      end
    end
  end
end
