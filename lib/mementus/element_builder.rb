module Mementus
  module ElementBuilder
    attr_accessor :id, :label

    def props
      @props ||= {}
    end

    def props=(props_map)
      @props = props_map
    end
  end
end
