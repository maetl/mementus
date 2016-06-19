module Mementus
  class BreadthFirstSearch
    def initialize(graph, start_id)
      @graph = graph
      @start_id = start_id
      @visited = { @start_id => true }
      @queue = []
    end

    def each(&block)
      visit(@start_id, &block)
    end

    private

    def visit(id, &block)
      @queue.concat(@graph.adjacent(id))

      while next_node = @queue.shift
        next if @visited[next_node]

        @visited[next_node] = true
        block.call(next_node)
        @queue.concat(@graph.adjacent(next_node.id))
      end
    end
  end
end
