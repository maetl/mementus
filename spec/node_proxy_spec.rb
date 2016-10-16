require 'spec_helper'

describe Mementus::NodeProxy do
  specify '#outgoing' do
    graph = Mementus::Graph.new do
      set_edge(edge_1_2)
      set_edge(edge_1_3)
    end

    node_proxy = Mementus::NodeProxy.new(node_1, graph)
    expect(node_proxy.outgoing.map { |node| node.id }).to eq([node_2.id, node_3.id])
  end

  specify '#outgoing_edges' do
    graph = Mementus::Graph.new do
      set_edge(edge_1_2)
      set_edge(edge_1_3)
    end

    node_proxy = Mementus::NodeProxy.new(node_1, graph)
    expect(node_proxy.outgoing_edges.map { |edge| edge.to.id }).to eq([node_2.id, node_3.id])
  end
end
