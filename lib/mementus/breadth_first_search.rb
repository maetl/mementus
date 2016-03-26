module Mementus
  class BreadthFirstSearch
    def initialize(graph, start)
      @graph = graph
      @start = start
      @visited = { @start => true }
      @queue = []
    end

    def each(&block)
      visit(NodeProxy.new(@start, graph), &block)
    end

    private

    def visit(node, &block)
      @queue << node.adjacent

      while next_node = @queue.shift
        next if @visited[next_node]

        @visited[next_node] = true
        block.call(next_node)
        @queue << next_node.adjacent
      end
    end
  end
end
