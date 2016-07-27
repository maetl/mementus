module Mementus
  class Node
    attr_reader :id, :label, :props

    def initialize(id: nil, label: nil, props: {})
      @id = id
      @label = label
      @props = props.freeze
    end

    def [](prop)
      @props[prop]
    end
  end
end
