require 'spec_helper'

describe Mementus::NodeProxy do
  specify '#new' do
    graph = Mementus::Graph.new
    node1 = Mementus::Node.new(1, :node)
    node2 = Mementus::Node.new(2, :node)
    node3 = Mementus::Node.new(3, :node)
    graph.add_edge(Mementus::Edge.new(node1, node2))
    graph.add_edge(Mementus::Edge.new(node1, node3))

    node_proxy = Mementus::NodeProxy.new(node1, graph)
    expect(node_proxy.edges).to eq([node2, node3])
  end
end
