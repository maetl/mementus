require 'spec_helper'

describe Mementus::EdgeProxy do
  let(:graph) do
    Mementus::Graph.new do
      set_edge(edge_1_2)
      set_edge(edge_1_3)
    end
  end

  specify '#from' do
    edge_proxy = Mementus::EdgeProxy.new(edge_1_2, graph)
    expect(edge_proxy.from.id).to eq(node_1.id)
  end

  specify '#to' do
    edge_proxy = Mementus::EdgeProxy.new(edge_1_2, graph)
    expect(edge_proxy.to.id).to eq(node_2.id)
  end
end
