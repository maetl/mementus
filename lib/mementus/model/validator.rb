module Mementus
  module Model
    # Checks values plugged into each slot and runs any required validations
    # (validations not yet implemented).
    #
    # Current design raises errors rather than returns a boolean result.
    class Validator
      # @param fields_spec [Hash] defines the slots in the schema to validate against
      def initialize(fields_spec)
        @spec = fields_spec
      end

      # Checks a given set of fields to see if they match the specification.
      #
      # Raises an error when the given fields are invalid.
      def check(fields)
        missing_fields = @spec.keys.difference(fields.keys)

        if missing_fields.any?
          missing_fields.each do |field|
            raise "wrong number of args" unless @spec[field].eql?(Type::Any)
          end
        end

        mismatching_fields = fields.keys.difference(@spec.keys)

        raise "key does not exist" if mismatching_fields.any?

        fields.each do |(field, value)|
          raise "wrong data type" unless value.is_a?(@spec[field]) || @spec[field].eql?(Type::Any)
        end

        true
      end
    end
  end
end
