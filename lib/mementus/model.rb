require 'virtus'
require 'axiom-memory-adapter'
 
module Mementus
 
  # Proof of concept for a toy ORM that combines some aspects of the
  # ActiveRecord API with an in-memory query model based on the Axiom
  # relational algebra API.
  #
  # The weirdest trick is that the data stored in the relational model
  # is a read-only index that never gets re-materialised back into the
  # model objects themselves (though Axiom does seem to be capable of
  # doing this).
  # 
  # Instead of returning mapped data from queries, the Ruby object_id
  # is used as a reference to point to the existing instance in the
  # runtime object space.
  #
  class Model
 
    @@local_storage = nil
    @@model_registry = {}
 
    def self.name_to_sym  
      name_without_namespace = name.split("::").last
      name_without_namespace.gsub(/([^\^])([A-Z])/,'\1_\2').downcase.to_sym
    end
 
    # TODO: this mapping could be based on declared indexes,
    # rather than dumping the entire attribute schema here.
    #
    def schema_tuple
      tuple = [[:__object_id, String]]
      attribute_set.each do |attribute_type|
        tuple << [attribute_type.name.to_sym, attribute_type.primitive]
      end
      tuple
    end
 
    # TODO: this mapping could be based on declared indexes,
    # rather than dumping the entire attribute data set here.
    #
    def values_tuple
      tuple = [object_id.to_s]
      attributes.each do |_, attribute_value|
        tuple << attribute_value
      end
      tuple
    end
 
    def self.inherited(concrete_model)
      concrete_model.send(:include, Virtus.model)
    end
 
    # Create only writes to memory. It's required in order to
    # index the object's attributes in the query model.
    #
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
 
    # Stub implementation that demonstrates the ObjectSpace
    # reference grabbing.
    #
    # Currently just splats to an array instead of handing back
    # a chainable scope object.
    # 
    def self.where(constraints)
      self.collection.restrict(constraints).inject([]) do |list, relation|
        list << ObjectSpace._id2ref(relation[:__object_id].to_i)
      end
    end
 
  end
end
