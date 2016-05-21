module Mementus
  class NodeBuilder
    attr_reader :id, :label

    def initialize(id=nil, label=:node)
      @id = id
      @label = label
    end

    def id=(id)
      @id = id
    end

    def label=(label)
      @label = label
    end
  end
end
