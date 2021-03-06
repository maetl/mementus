module Mementus
  class NodeBuilder
    include ElementBuilder

    def to_node
      Node.new(id: id, label: label, props: props)
    end
  end
end
