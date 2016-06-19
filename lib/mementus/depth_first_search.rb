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
      @graph.each_adjacent(id) do |adj_node|
        next if @visited[adj_node.id]

        @visited[adj_node.id] = true
        block.call(adj_node)
        visit(adj_node.id, &block)
      end
    end
  end
end
