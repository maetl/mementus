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

      while next_id = @queue.shift
        next if @visited[next_id]

        @visited[next_id] = true
        block.call(NodeProxy.new(next_id, @graph))
        @queue.concat(@graph.adjacent(next_id))
      end
    end
  end
end
