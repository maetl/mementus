require 'spec_helper'

describe Mementus::Model do

  describe "Attributes" do
    
    class PrimaryAttributes < Mementus::Model
      attribute :name, String
      attribute :count, Integer
      attribute :switch, Boolean
    end

    let(:model) {
      PrimaryAttributes.new(
        :name => "a string",
        :count => 500,
        :switch => false
      )
    }

    it "reads attributes" do
      expect(model.name).to eq "a string"
      expect(model.count).to eq 500
      expect(model.switch).to eq false
    end

    it "writes attributes" do
      model.name = "stringstringstring"
      model.count = 488
      model.switch = true

      expect(model.name).to eq "stringstringstring"
      expect(model.count).to eq 488
      expect(model.switch).to eq true      
    end

  end


end
