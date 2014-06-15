require 'spec_helper'

describe Mementus::Model do

  describe "Mapping" do

    class Mapping < Mementus::Model
      attribute :description, String
      attribute :number, Integer
    end

    let(:mapping) {
      Mapping.new(
        :description => "Hello world.",
        :number => 2014
      )
    }

    let(:object_id) {
        mapping.object_id.to_s
    }

    it "maps attribute schema to tuple" do
      schema = [[:__object_id, String], [:description, String], [:number, Integer]]
      expect(mapping.schema_tuple).to eq schema
    end

    it "maps attribute values to tuple" do
      values = [object_id, "Hello world.", 2014]
      expect(mapping.values_tuple).to eq values
    end

  end

end
