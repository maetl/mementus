require 'spec_helper'

shared_examples_for "an indexed graph data structure" do
  describe '#new' do
    it 'starts with empty node list' do
      expect(structure.nodes_count).to eq(0)
    end

    it 'starts with empty edge list' do
      expect(structure.edges_count).to eq(0)
    end
  end

  describe '#set_node' do
    it 'assigns a node object to the graph' do
      structure.set_node(Mementus::Node.new(id: 1))

      expect(structure.nodes_count).to eq(1)
      expect(structure.edges_count).to eq(0)
    end
  end

  describe '#set_edge' do
    it 'adds an edge object to the graph' do
      structure.set_edge(Mementus::Edge.new(from: Mementus::Node.new(id: 1), to: Mementus::Node.new(id: 2)))

      expect(structure.nodes_count).to eq(2)
      expect(structure.edges_count).to eq(1)
    end
  end

  describe '#has_node?' do
    it 'tests for the presence of a given node' do
      node = Mementus::Node.new(id: 1)
      structure.set_node(node)

      expect(structure.has_node?(1)).to be true
    end
  end

  describe '#has_edge?' do
    it 'tests for the presence of a given edge' do
      edge = Mementus::Edge.new(from: Mementus::Node.new(id: 1), to: Mementus::Node.new(id: 2))
      structure.set_edge(edge)

      expect(structure.has_edge?(edge)).to be true
    end
  end

  describe '#node(id)' do
    it 'finds a node by id' do
      edge = Mementus::Edge.new(from: Mementus::Node.new(id: 1), to: Mementus::Node.new(id: 2))
      structure.set_edge(edge)

      expect(structure.node(1).id).to eq(edge.from.id)
    end
  end

  describe '#nodes' do
    it 'lists all nodes in the graph' do
      edge = Mementus::Edge.new(from: Mementus::Node.new(id: 1), to: Mementus::Node.new(id: 2))
      structure.set_edge(edge)

      expect(structure.nodes.first.id).to eq(edge.from.id)
      expect(structure.nodes.last.id).to eq(edge.to.id)
    end
  end
end
