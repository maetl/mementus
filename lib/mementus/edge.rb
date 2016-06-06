module Mementus
  class Edge
    attr_reader :from, :to, :label

    def initialize(from, to, label=:edge)
       @from = if from.is_a?(Integer)
         Node.new(from)
       else
         from
       end

       @to = if to.is_a?(Integer)
         Node.new(to)
       else
         to
       end

      @label = label
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
