module Mementus
  class EdgeBuilder
    include ElementBuilder

    attr_reader :from, :to

    def from=(node, label=:node)
      if node.is_a?(Node)
        @from = node
      else
        @from = Node.new(id: node, label: label)
      end
    end

    def to=(node)
      if node.is_a?(Node)
        @to = node
      else
        @to = Node.new(id: node, label: label)
      end
    end

    def to_edge
      Edge.new(id: id, from: from, to: to, label: label, props: props)
    end
  end
end
