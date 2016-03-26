module Mementus
  class Edge
    attr_reader :from, :to

    def initialize(from, to)
      @from = from
      @to = to
    end

    def nodes
      [@from, @to]
    end

    def other(node)
      @from == node ? @to : @from
    end
  end
end
