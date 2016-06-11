module Mementus
  class EdgeBuilder
    attr_reader :from, :to, :label, :id

    def initialize(from=nil, to=nil, label=:edge, id=nil)
      @from = from
      @to = to
      @label = label
      @id = id
    end

    def id=(id)
      @id = id
    end

    def from=(node, label=:node)
      if node.is_a?(Node)
        @from = node
      else
        @from = Node.new(node, label)
      end
    end

    def to=(node)
      if node.is_a?(Node)
        @to = node
      else
        @to = Node.new(node, label)
      end
    end

    def label=(label)
      @label = label
    end

    def nodes
      [@from, @to]
    end

    def other(node)
      @from == node ? @to : @from
    end
  end
end
