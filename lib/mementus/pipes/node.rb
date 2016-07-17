module Mementus
  module Pipes
    class Node < Pipeline::Transform
      def process(id)
        #@graph.node(id)
        puts id
      end
    end
  end
end
