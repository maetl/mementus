module Mementus
  class Edge
    attr_reader :from, :to, :label

    def initialize(from, to, label=:edge)
      @from = from
      @to = to
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
