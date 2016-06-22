module Mementus
  module Pipes
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
  end
end
