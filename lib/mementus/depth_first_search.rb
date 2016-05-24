module Mementus
  class DepthFirstSearch
    def initialize(graph, start_id)
      @graph = graph
      @start_id = start_id
      @visited = { @start_id => true }
    end

    def each(&block)
      visit(@start_id, &block)
    end

    private

    def visit(id, &block)
      @graph.each_adjacent(id) do |adjacent_id|
        next if @visited[adjacent_id]

        @visited[adjacent_id] = true
        block.call(NodeProxy.new(adjacent_id, @graph))
        visit(adjacent_id, &block)
      end
    end
  end
end
