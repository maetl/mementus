module Mementus
  class Direction
    IN = :in
    OUT = :out
    BOTH = :both

    def self.flip(direction)
      case direction
      when IN then OUT
      when OUT then IN
      else
        BOTH
      end
    end
  end
end
