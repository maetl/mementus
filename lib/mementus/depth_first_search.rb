module Mementus
  class DepthFirstSearch
    def initialize(graph, start)
      @graph = graph
      @start = start
      @visited = { @start => true }
    end

    def each(&block)
      visit(NodeProxy.new(@start, @graph), &block)
    end

    private

    def visit(node, &block)
      node.each_adjacent do |adjacent|
        next if @visited[adjacent]

        @visited[adjacent] = true
        block.call(adjacent)
        visit(NodeProxy.new(adjacent, @graph), &block)
      end
    end
  end
end
