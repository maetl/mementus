module Mementus
  class NodeBuilder
    attr_reader :id, :label, :props

    def initialize(options={})
      id = options[:id]
      label = options[:label]
      props = options[:props]
    end

    def id=(id)
      @id = id
    end

    def label=(label)
      @label = label
    end

    def props=(props)
      @props = props
    end
  end
end
