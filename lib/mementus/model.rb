require 'virtus'
require 'axiom-memory-adapter'
 
module Mementus
 
  # Proof of concept for a toy ORM that combines some aspects of the
  # ActiveRecord API with an in-memory query model based on the Axiom
  # relational algebra API.
  #
  class Model

    def self.inherited(concrete_model)
      concrete_model.send(:include, Virtus.model)
      concrete_model.send(:extend, Relation::ClassMethods)
    end

    @@local_storage = nil
    @@model_registry = {}
 
    def self.name_to_sym  
      name_without_namespace = name.split("::").last
      name_without_namespace.gsub(/([^\^])([A-Z])/,'\1_\2').downcase.to_sym
    end

    # Unique cache identifier for this instance
    #
    def cache_key
      "#{self.class.name_to_sym.to_s}-#{object_id.to_s}"
    end
 
    # TODO: this mapping could be based on declared indexes,
    # rather than dumping the entire attribute schema here.
    #
    def schema_tuple
      tuple = [[:__cache_key, String]]
      attribute_set.each do |attribute_type|
        tuple << [attribute_type.name.to_sym, attribute_type.primitive]
      end
      tuple
    end
 
    # TODO: this mapping could be based on declared indexes,
    # rather than dumping the entire attribute data set here.
    #
    def values_tuple
      tuple = [cache_key]
      attributes.each do |_, attribute_value|
        tuple << attribute_value
      end
      tuple
    end
 
    # Create only writes to memory. It's required in order to
    # index the object's attributes in the query model.
    #
    def create
      ensure_registered(self)
      local_storage[self.class.name_to_sym].insert([values_tuple])
      self.class.cache_put(self.cache_key, self)
    end
 
    def ensure_registered(model)
      register(model) unless registered?(model)
    end
 
    def registered?(model)
      model_registry.has_key? model.class.name_to_sym
    end
 
    def register(model)
      model_id = model.class.name_to_sym
      model_registry[model_id] = true
      local_storage[model_id] = Axiom::Relation.new(model.schema_tuple)
    end
 
    def model_registry
      @@model_registry
    end
 
    def local_storage
      @@local_storage ||= Axiom::Adapter::Memory.new
    end
 
    def self.collection
      @@local_storage[name_to_sym]
    end

    # TODO: fix incomplete scope chaining
    def self.scope(name, conditions)
      if conditions.is_a? Hash
        scope_method = lambda { self.where(conditions) }
      elsif conditions.is_a? Proc
        scope_method = conditions
      end

      define_singleton_method(name, &scope_method)
    end

    private

    def self.cache
      @@cache ||= {}
    end

    def self.cache_put(cache_key, object)
      self.cache[cache_key] = object
    end

    def self.cache_get(cache_key)
      self.cache[cache_key]
    end
 
  end
end
