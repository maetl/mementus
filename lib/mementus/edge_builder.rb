module Mementus
  class EdgeBuilder
    attr_reader :id, :from, :to, :label, :props

    def initialize(options={})
      id = options[:id]
      from = options[:from]
      to = options[:to]
      label = options[:label]
      props = options[:props]
    end

    def id=(id)
      @id = id
    end

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
