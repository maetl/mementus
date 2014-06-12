module Mementus
  class Model

    @@local_storage = nil
    @@model_registry = {}

    def self.name_to_sym  
      name_without_namespace = name.split("::").last
      name_without_namespace.gsub(/([^\^])([A-Z])/,'\1_\2').downcase.to_sym
    end

    def schema_tuple
      tuple = []
      attribute_set.each do |attribute_type|
        tuple << [attribute_type.name.to_sym, attribute_type.primitive]
      end
      tuple
    end

    def values_tuple
      tuple = []
      attributes.each do |_, attribute_value|
        tuple << attribute_value
      end
      tuple
    end

    def self.inherited(concrete_model)
      concrete_model.send(:include, Virtus.model)
    end

    def create
      ensure_registered(self)
      local_storage[self.class.name_to_sym].insert([values_tuple])
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
      unless @@local_storage
        @@local_storage = Axiom::Adapter::Memory.new
      end
      @@local_storage
    end

    def self.collection
      @@local_storage[name_to_sym]
    end

  end
end