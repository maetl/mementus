module Mementus
  class BindingDelegator
    def initialize(instance, scope)
      @instance = instance
      @scope = scope.eval('self')
    end

    def method_missing(name, *args, &block)
      if @instance.respond_to?(name)
        @instance.send(name, *args, &block)
      else
        @scope.send(name, *args, &block)
      end
    end

    def respond_to_missing?(name)
      @scope.respond_to?(name) || @instance.respond_to?(name)
    end
  end
end
