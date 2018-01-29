module Mementus
  class DepthFirstSearch
    def initialize(graph, start_id, method=:out)
      @graph = graph
      @start_id = start_id
      @method = method
      @visited = { @start_id => true }
    end

    def each(&block)
      visit(@graph.node(@start_id), &block)
    end

    private

    def visit(node, &block)
      block.call(node)
      @visited[node.id] = true

      method = case @method
        when :out then :outgoing
        when :in then :incoming
      end

      @graph.send(method, node.id).each do |adj_node|
        next if @visited[adj_node.id]
        visit(adj_node, &block)
      end
    end
  end
end
