module Mementus
  class Criteria
    attr_reader :id, :label, :props

    def initialize(*match)
      @match = match
      @id = match.find { |arg| arg.is_a?(Numeric) }
      @label = match.find { |arg| arg.is_a?(Symbol) }
      @props = match.find { |arg| arg.is_a?(Hash) }
    end

    def empty?
      @match.empty?
    end
  end
end
