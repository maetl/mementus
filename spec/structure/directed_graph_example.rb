require 'spec_helper'

shared_examples_for 'a directed graph data structure' do
  it 'enumerates outgoing nodes from the given node' do
    edge = Mementus::Edge.new(from: Mementus::Node.new(id: 1), to: Mementus::Node.new(id: 2))
    structure.set_edge(edge)

    expect(structure.outgoing(1).first.id).to eq(2)
  end

  it 'enumerates outgoing edges from the given node' do
    edge = Mementus::Edge.new(id: 3, from: Mementus::Node.new(id: 1), to: Mementus::Node.new(id: 2))
    structure.set_edge(edge)

    expect(structure.outgoing_edges(1).first.id).to eq(3)
  end

  it 'enumerates incoming nodes from the given node' do
    edge = Mementus::Edge.new(from: Mementus::Node.new(id: 1), to: Mementus::Node.new(id: 2))
    structure.set_edge(edge)

    expect(structure.incoming(2).first.id).to eq(1)
  end

  it 'enumerates incoming edges from the given node' do
    edge = Mementus::Edge.new(id: 3, from: Mementus::Node.new(id: 1), to: Mementus::Node.new(id: 2))
    structure.set_edge(edge)

    expect(structure.incoming_edges(2).first.id).to eq(3)
  end
end
