shared_examples_for 'a mutable graph data structure' do
  before do
    structure.set_node(Mementus::Node.new(id: 1))
    structure.set_node(Mementus::Node.new(id: 2))
    structure.set_node(Mementus::Node.new(id: 3))

    structure.set_edge(Mementus::Edge.new(id: 10, from: 1, to: 2))
    structure.set_edge(Mementus::Edge.new(id: 20, from: 2, to: 3))
    structure.set_edge(Mementus::Edge.new(id: 30, from: 1, to: 3))
  end

  describe '#remove_node' do
    it 'removes all references to a given node' do
      structure.remove_node(Mementus::Node.new(id: 2))

      expect(structure.nodes.count).to eq(2)
      expect(structure.edges.count).to eq(1)
      expect(structure.node(1).outgoing.count).to eq(1)
      expect(structure.node(3).incoming.count).to eq(1)
      expect(structure.node(1).outgoing_edges.count).to eq(1)
      expect(structure.node(3).incoming_edges.count).to eq(1)
    end

    it 'removes all references to a given node id' do
      structure.remove_node(2)

      expect(structure.nodes.count).to eq(2)
      expect(structure.edges.count).to eq(1)
      expect(structure.node(1).outgoing.count).to eq(1)
      expect(structure.node(3).incoming.count).to eq(1)
      expect(structure.node(1).outgoing_edges.count).to eq(1)
      expect(structure.node(3).incoming_edges.count).to eq(1)
    end
  end

  describe '#remove_edge' do
    it 'removes all references to a given edge' do
      edge = Mementus::Edge.new(id: 10, from: 1, to: 2)
      structure.remove_edge(edge)

      expect(structure.nodes.count).to eq(3)
      expect(structure.edges.count).to eq(2)
      expect(structure.node(1).outgoing.count).to eq(1)
      expect(structure.node(2).incoming.count).to eq(0)
      expect(structure.node(1).outgoing_edges.count).to eq(1)
      expect(structure.node(2).incoming_edges.count).to eq(0)
    end

    it 'removes all references to a given edge id' do
      structure.remove_edge(10)

      expect(structure.nodes.count).to eq(3)
      expect(structure.edges.count).to eq(2)
      expect(structure.node(1).outgoing.count).to eq(1)
      expect(structure.node(2).incoming.count).to eq(0)
      expect(structure.node(1).outgoing_edges.count).to eq(1)
      expect(structure.node(2).incoming_edges.count).to eq(0)
    end
  end
end
