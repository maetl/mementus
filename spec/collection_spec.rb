require 'spec_helper'

describe Mementus::Model do

  describe "Collection" do
  
    class Item < Mementus::Model
      attribute :name, String
      attribute :order, Integer
    end

    20.times do |i|
      item = Item.new
      item.name = "Item: #{i.to_s}"
      item.order = i + 1
      item.create
    end

    it "counts created items" do
      expect(Item.collection.count).to eq 20
    end

    it "finds item by matching attribute" do
      expect(Item.where(order: 10).count).to eq 1
      expect(Item.where(order: 10).first.name).to eq "Item: 9"
    end

  end

end
