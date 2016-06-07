require 'spec_helper'

shared_examples_for "a mutable graph data structure" do
  describe '#new' do
    it 'starts with empty node list' do
      expect(structure.nodes_count).to eq(0)
    end

    it 'starts with empty edge list' do
      expect(structure.edges_count).to eq(0)
    end
  end

  describe '#add_node' do
    it 'adds a node object to the graph' do
      structure.add_node(Mementus::Node.new(1, :node))

      expect(structure.nodes_count).to eq(1)
      expect(structure.edges_count).to eq(0)
    end
  end

  describe '#add_edge' do
    it 'adds an edge object to the graph' do
      structure.add_edge(Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(2, :node)))

      expect(structure.nodes_count).to eq(2)
      expect(structure.edges_count).to eq(1)
    end
  end

  describe '#has_node?' do
    it 'tests for the presence of a given node' do
      node = Mementus::Node.new(1, :node)
      structure.add_node(node)

      expect(structure.has_node?(node)).to be true
    end
  end

  describe '#has_edge?' do
    it 'tests for the presence of a given edge' do
      edge = Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(2, :node))
      structure.add_edge(edge)

      expect(structure.has_edge?(edge)).to be true
    end
  end

  describe '#node(id)' do
    it 'finds a node by id' do
      edge = Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(2, :node))
      structure.add_edge(edge)

      expect(structure.node(1).id).to eq(edge.from.id)
    end
  end

  describe '#nodes' do
    it 'lists all nodes in the graph' do
      edge = Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(2, :node))
      structure.add_edge(edge)

      expect(structure.nodes.first.id).to eq(edge.from.id)
      expect(structure.nodes.last.id).to eq(edge.to.id)
    end
  end
end

describe Mementus::Structure::AdjacencyList do
  let(:structure) do
    Mementus::Structure::AdjacencyList.new
  end

  it_behaves_like "a mutable graph data structure"
end

describe Mementus::Structure::IncidenceList do
  let(:structure) do
    Mementus::Structure::IncidenceList.new
  end

  it_behaves_like "a mutable graph data structure"
end
