require 'spec_helper'

describe Mementus::Model do

  describe "Empty" do

    class EmptyItem < Mementus::Model
      attribute :id, String
    end

    it "returns an empty collection when no items found" do
      expect(EmptyItem.all).to be_instance_of(Array)
      expect(EmptyItem.all.count).to eq 0
    end

  end

end
