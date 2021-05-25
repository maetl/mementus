module Mementus
  module Model
    # Value object with comparison by value equality.
    #
    # This is a wrapper class, used as a factory for generating instances of
    # Ruby structs that wraps the Struct constructor with method advice
    # to handle validation (and eventually type coercion if needed).
    class Value
      def self.new(*slots, **fields, &block)
        define(*slots, **fields, &block)
      end

      def self.define(*slots, **fields, &block)
        # Cannot define a Value without specifying slots or fields
        if slots.empty? && fields.empty?
          raise ArgumentError.new("missing attribute definition")
        end

        # Build and validate an attribute specification matching the stdlib
        # constructor convention
        slots_spec, fields_spec = if fields.any?
          raise ArgumentError.new("cannot use slots when field map is supplied") if slots.any?
          [fields.keys, fields]
        else
          [slots, Hash[slots.map { |s| [s, Type::Any]}]]
        end

        validator = Validator.new(fields_spec)

        # Define a new struct with the given specification of attributes
        struct = Struct.new(*slots_spec, keyword_init: true, &block)

        # Method advice wrapping the stdlib constructor
        struct.define_method :initialize do |*args, **kwargs|

          # Handles the original stdlib API of slot-based args if you really
          # must do things this way. The keyword args API is the preferred
          # approach.
          attr_values = if args.any?
            raise ArgumentError.new("cannot mix slots and kwargs") if kwargs.any?
            Hash[slots.zip(args)]
          else
            kwargs
          end

          # Check that the provided values match the defined attributes and types
          validator.check(attr_values)

          # TODO: type coercion or mapping decision goes here

          super(**attr_values)

          # Freeze the instance before returning to caller
          # TODO: if immutability becomes optional this needs to be wrapped
          freeze
        end

        struct
      end
    end
  end
end
