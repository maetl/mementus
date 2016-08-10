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

      expect(structure.has_node?(node)).to be true
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

  describe '#nodes(match)' do
    it 'matches all nodes with the given prop' do
      structure.set_node(Mementus::Node.new(id: 1, props: { tag: 'point'}))
      structure.set_node(Mementus::Node.new(id: 2, props: { tag: 'point'}))
      structure.set_node(Mementus::Node.new(id: 3))

      structure.nodes(tag: 'point').tap do |matched|
        expect(matched.first.id).to eq(1)
        expect(matched.last.id).to eq(2)
      end
    end

    it 'matches all nodes with the given label' do
      structure.set_node(Mementus::Node.new(id: 1, label: :point))
      structure.set_node(Mementus::Node.new(id: 2, label: :point))
      structure.set_node(Mementus::Node.new(id: 3))

      structure.nodes(:point).tap do |matched|
        expect(matched.first.id).to eq(1)
        expect(matched.last.id).to eq(2)
      end
    end
  end

  describe '#edges' do
    it 'lists all edges in the graph' do
      edge = Mementus::Edge.new(id: 3, from: Mementus::Node.new(id: 1), to: Mementus::Node.new(id: 2))
      structure.set_edge(edge)

      structure.edges.tap do |matched|
        expect(matched.first.id).to eq(edge.id)
        expect(matched.first.from.id).to eq(edge.from.id)
        expect(matched.first.to.id).to eq(edge.to.id)
      end
    end
  end

  describe '#edges(match)' do
    it 'matches all edges with the given prop' do
      edge = Mementus::Edge.new(props: { tag: 'link' }, from: Mementus::Node.new(id: 1), to: Mementus::Node.new(id: 2))
      structure.set_edge(edge)

      structure.edges(tag: 'link').tap do |matched|
        expect(matched.first.id).to eq(edge.id)
        expect(matched.first.from.id).to eq(edge.from.id)
        expect(matched.first.to.id).to eq(edge.to.id)
      end
    end

    it 'matches all edges with the given label' do
      edge = Mementus::Edge.new(label: :link, from: Mementus::Node.new(id: 1), to: Mementus::Node.new(id: 2))
      structure.set_edge(edge)

      structure.edges(:link).tap do |matched|
        expect(matched.first.id).to eq(edge.id)
        expect(matched.first.from.id).to eq(edge.from.id)
        expect(matched.first.to.id).to eq(edge.to.id)
      end
    end
  end
end
