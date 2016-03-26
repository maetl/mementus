module Mementus
  class Node
    attr_reader :id, :label

    def initialize(id, label)
      @id = id
      @label = label
    end
  end
end
