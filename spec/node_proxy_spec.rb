require 'spec_helper'

describe Mementus::NodeProxy do
  specify '#adjacent' do
    node1 = Mementus::Node.new(id: 1)
    node2 = Mementus::Node.new(id: 2)
    node3 = Mementus::Node.new(id: 3)
    graph = Mementus::Graph.new do
      add_edge(Mementus::Edge.new(from: node1, to: node2))
      add_edge(Mementus::Edge.new(from: node1, to: node3))
    end

    node_proxy = Mementus::NodeProxy.new(1, graph)
    expect(node_proxy.adjacent.map { |node| node.id}).to eq([node2.id, node3.id])
  end
end
