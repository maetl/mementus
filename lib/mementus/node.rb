module Mementus
  class Node
    attr_reader :id, :label

    def initialize(id: nil, label: nil)
      @id = id
      @label = label
    end
  end
end
