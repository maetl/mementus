module Mementus
  module ElementBuilder
    attr_accessor :id, :label

    def props
      @props ||= {}
    end
  end
end
