module Axiom
  module Adapter
    class Memory
      # Patch for missing hash check in Axiom memory adapter
      def has_key?(key)
        schema.has_key?(key)
      end
    end
  end
end
