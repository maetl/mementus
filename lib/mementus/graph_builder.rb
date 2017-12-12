module Mementus
  class GraphBuilder
    include Mutators

    def initialize(is_directed)
      @structure = Structure::IncidenceList.new(is_directed)
      @node_ids = IntegerId.new
      @edge_ids = IntegerId.new
    end

    def graph
      @structure
    end
  end
end
