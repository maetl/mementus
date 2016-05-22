require 'spec_helper'

describe Mementus::NodeProxy do
  specify '#new' do
    node1 = Mementus::Node.new(1, :node)
    node2 = Mementus::Node.new(2, :node)
    node3 = Mementus::Node.new(3, :node)
    graph = Mementus::Graph.new do
      add_edge(Mementus::Edge.new(node1, node2))
      add_edge(Mementus::Edge.new(node1, node3))
    end

    node_proxy = Mementus::NodeProxy.new(node1, graph)
    expect(node_proxy.adjacent.map { |node| node.id}).to eq([node2.id, node3.id])
  end
end
