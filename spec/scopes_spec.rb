require 'spec_helper'

describe Mementus::Model do

  class CuteThing < Mementus::Model
    attribute :name, String
    attribute :category, String
    scope :cats, category: "cats"
    scope :dogs, category: "dogs"
  end

  before(:all) do
    20.times do |i|
      thing = CuteThing.new
      thing.name = rand(36**12).to_s(36)
      thing.category = (i % 2) == 0 ? "dogs" : "cats"
      thing.create
    end
  end

  describe "#scope" do

    it "can execute named scopes" do
      expect(CuteThing.cats.count).to eq 10
      expect(CuteThing.dogs.count).to eq 10
    end

  end

end
