require 'spec_helper'

shared_examples_for 'a property graph data structure' do
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
