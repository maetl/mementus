require 'spec_helper'

describe Mementus::Structure do
  let(:structure) do
    Mementus::Structure.new
  end

  specify '#new' do
    expect(structure.nodes_count).to eq(0)
    expect(structure.edges_count).to eq(0)
  end

  specify '#add_node' do
    structure.add_node(Mementus::Node.new(1, :node))

    expect(structure.nodes_count).to eq(1)
    expect(structure.edges_count).to eq(0)
  end

  specify '#add_edge' do
    structure.add_edge(Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(2, :node)))

    expect(structure.nodes_count).to eq(2)
    expect(structure.edges_count).to eq(1)
  end

  specify '#has_node?' do
    node = Mementus::Node.new(1, :node)
    structure.add_node(node)

    expect(structure.has_node?(node)).to be true
    expect(structure.has_node?(node.dup)).to be false
  end

  specify '#has_edge?' do
    edge = Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(2, :node))
    edge2 = Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(2, :node))
    structure.add_edge(edge)

    expect(structure.has_edge?(edge)).to be true
    expect(structure.has_edge?(edge2)).to be false
  end

  specify '#node(id)' do
    edge = Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(2, :node))
    structure.add_edge(edge)

    expect(structure.node(1)).to eq(edge.from)
  end

  specify '#nodes(filter)' do
    edge = Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(2, :node))
    structure.add_edge(edge)

    expect(structure.nodes).to eq([edge.from, edge.to])
  end
end
