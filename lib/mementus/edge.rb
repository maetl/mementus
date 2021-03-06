module Mementus
  class Edge
    attr_reader :from, :to, :label, :id

    def initialize(id: nil, from:, to:, label: :edge, props: {})
      @id = id
      @label = label
      @props = props.freeze

      @from = if from.is_a?(Integer)
        Node.new(id: from)
      else
        from
      end

      @to = if to.is_a?(Integer)
        Node.new(id: to)
      else
        to
      end
    end

    def [](prop)
      @props[prop]
    end

    def nodes
      [@from, @to]
    end

    def ==(edge)
      from.id == edge.from.id && to.id == edge.to.id && label == edge.label
    end

    alias :eql? :==

    def hash
      [from.id, to.id].hash
    end
  end
end
