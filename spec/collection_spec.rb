require 'spec_helper'

describe Mementus::Model do

  describe "Collection" do
  
    class Item < Mementus::Model
      attribute :name, String
      attribute :order, Integer
    end

    before(:all) do
      20.times do |i|
        item = Item.new
        item.name = "Item: #{i.to_s}"
        item.order = i + 1
        item.create
      end
    end

    it "counts created items" do
      expect(Item.collection.count).to eq 20
    end

    it "provides materialized objects" do
      expect(Item.all.count).to eq 20
      expect(Item.all.first.name).to eq "Item: 0"
    end

    it "finds item by equality match" do
      expect(Item.where(order: 10).count).to eq 1
      expect(Item.where(order: 10).first.name).to eq "Item: 9"
    end

    it "finds items by predicate match" do
      collection = Item.order(order: :desc)
      expect(collection.count).to eq 20
      expect(collection.first.name).to eq "Item: 19"
      expect(collection.last.name).to eq "Item: 0"
    end

  end

end
