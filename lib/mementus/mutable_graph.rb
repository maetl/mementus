module Mementus
  class MutableGraph < Graph
    include Mutators

    def initialize
      @structure = Structure::IncidenceList.new(true)
      @node_ids = IntegerId.new
      @edge_ids = IntegerId.new
    end
  end
end
