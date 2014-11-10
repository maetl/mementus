module Mementus
  module Relation
    module ClassMethods

      def where(constraints)
        Query.new(self.collection, self.cache).where(constraints)
      end

      def all
        Query.new(self.collection, self.cache).all
      end

      def order(constraints)
        Query.new(self.collection, self.cache).order(constraints)
      end

    end

    # Chainable query object that delegates to the given relation.
    class Query

      def initialize(relation, cache)
        @relation = relation
        @cache = cache
      end

      # Filters the collection based on the given constraints.
      #
      # - Pass in a key-value hash to filter based on matching attributes by equality.
      # - Pass in a block to construct a more specialised predicate match.
      def where(constraints)
        Query.new(@relation.restrict(constraints), @cache)
      end

      # Order the collection by attribute and direction
      def order(constraints)
        ordered_relation = @relation.sort_by do |relation|
          constraints.keys.inject([]) do |list, constraint|
            direction = constraints[constraint].to_sym
            direction = :asc unless direction == :desc
            list << relation.send(constraint.to_sym).send(direction)
          end
        end
        Query.new(ordered_relation, @cache)
      end

      # Materializes the relation to an array of model objects.
      def all
        @relation.inject([]) do |list, relation|
          list << @cache[relation[:__cache_key]]
        end
      end

    end
  end
end