require 'spec_helper'

describe 'pipeline api' do
  let(:graph) do
    Mementus::Graph.new do
      create_node do |node|
        node.id = 1
        node.label = :passage
        node.props[:name] = 'one'
      end

      create_node do |node|
        node.id = 2
        node.label = :passage
        node.props[:name] = 'two'
      end

      create_node do |node|
        node.id = 4
        node.label = :passage
        node.props[:name] = 'three'
      end

      create_edge do |edge|
        edge.id = 3
        edge.from = 1
        edge.to = 2
        edge.label = :choice
        edge.props[:name] = 'e3'
      end

      create_edge do |edge|
        edge.id = 5
        edge.from = 2
        edge.to = 4
        edge.label = :choice
        edge.props[:name] = 'e5'
      end
    end
  end

  describe '#n' do
    it 'traverses from the given node id' do
      pipeline = graph.n(1)
      expect(pipeline.id).to eq(1)
      expect(pipeline.first.id).to eq(1)
    end

    it 'traverses from the given label match' do
      pipeline = graph.n(:passage)
      expect(pipeline.id).to eq([1, 2, 4])
      expect(pipeline.first.id).to eq(1)
    end

    it 'traverses from the given prop match' do
      pipeline = graph.n(name: 'one')
      expect(pipeline.id).to eq(1)
      expect(pipeline.first.id).to eq(1)
    end
  end

  describe '#out' do
    it 'traverses to outgoing nodes' do
      pipeline = graph.n(1).out
      expect(pipeline.all.count).to eq(1)
      expect(pipeline.all.first.id).to eq(2)
    end

    it 'traverses to outgoing nodes matching label' do
      pipeline = graph.n(1).out(:passage)
      expect(pipeline.all.count).to eq(1)
      expect(pipeline.all.first.id).to eq(2)
    end

    it 'traverses to outgoing nodes matching filter' do
      pipeline = graph.n(1).out(name: 'two')
      expect(pipeline.all.count).to eq(1)
      expect(pipeline.all.first.id).to eq(2)
    end

    it 'traverses to second-degree outgoing nodes' do
      pipeline = graph.n(1).out.out
      expect(pipeline.all.count).to eq(1)
      expect(pipeline.all.first.id).to eq(4)
    end
  end

  describe '#out_e' do
    it 'traverses to outgoing edges' do
      pipeline = graph.n(1).out_e
      expect(pipeline.all.count).to eq(1)
      expect(pipeline.all.first.to.id).to eq(2)
    end

    it 'traverses to outgoing edges matching label' do
      pipeline = graph.n(1).out_e(:choice)
      expect(pipeline.all.count).to eq(1)
      expect(pipeline.all.first.to.id).to eq(2)
    end

    it 'traverses to outgoing edges matching filter' do
      pipeline = graph.n(1).out_e(name: 'e3')
      expect(pipeline.all.count).to eq(1)
      expect(pipeline.all.first.to.id).to eq(2)
    end
  end

  describe '#in' do
    it 'traverses to incoming nodes' do
      pipeline = graph.n(2).in
      expect(pipeline.all.count).to eq(1)
      expect(pipeline.all.first.id).to eq(1)
    end

    it 'traverses to incoming nodes matching label' do
      pipeline = graph.n(2).in(:passage)
      expect(pipeline.all.count).to eq(1)
      expect(pipeline.all.first.id).to eq(1)
    end

    it 'traverses to incoming nodes matching filter' do
      pipeline = graph.n(2).in(name: 'one')
      expect(pipeline.all.count).to eq(1)
      expect(pipeline.all.first.id).to eq(1)
    end
  end

  describe '#in_e' do
    it 'traverses to incoming edges' do
      pipeline = graph.n(2).in_e
      expect(pipeline.all.count).to eq(1)
      expect(pipeline.all.first.from.id).to eq(1)
    end

    it 'traverses to incoming edges matching label' do
      pipeline = graph.n(2).in_e(:choice)
      expect(pipeline.all.count).to eq(1)
      expect(pipeline.all.first.from.id).to eq(1)
    end

    it 'traverses to incoming edges matching filter' do
      pipeline = graph.n(2).in_e(name: 'e3')
      expect(pipeline.all.count).to eq(1)
      expect(pipeline.all.first.from.id).to eq(1)
    end
  end

  describe 'pipeline steps pull values lazily' do

  end

  describe '#traversal API pending' do
    let(:traversal_graph) do
      Mementus::Graph.new do
        set_edge(Mementus::Edge.new(from: Mementus::Node.new(id: 1), to: Mementus::Node.new(id: 2)))
        set_edge(Mementus::Edge.new(from: Mementus::Node.new(id: 2), to: Mementus::Node.new(id: 3)))
        set_edge(Mementus::Edge.new(from: Mementus::Node.new(id: 2), to: Mementus::Node.new(id: 5)))
        set_edge(Mementus::Edge.new(from: Mementus::Node.new(id: 1), to: Mementus::Node.new(id: 6)))
        set_edge(Mementus::Edge.new(from: Mementus::Node.new(id: 2), to: Mementus::Node.new(id: 7)))
        set_edge(Mementus::Edge.new(from: Mementus::Node.new(id: 7), to: Mementus::Node.new(id: 8)))
        set_edge(Mementus::Edge.new(from: Mementus::Node.new(id: 5), to: Mementus::Node.new(id: 9)))
      end
    end

    it 'traverses through outgoing nodes breadth first' do
      pipeline = traversal_graph.n(1)

      expected = [1,2,6,3,5,7,9,8]
      expect(pipeline.breadth_first.all.map(&:id)).to eq(expected)
    end

    it 'traverses through incoming nodes depth first' do
      pipeline = traversal_graph.n(1)

      expected = [1,2,3,5,9,7,8,6]
      expect(pipeline.depth_first.all.map(&:id)).to eq(expected)
    end
  end
end
