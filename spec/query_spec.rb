require 'spec_helper'

describe Mementus::Query do
  let(:graph) do
    Mementus::Graph.new do
      add_edge(Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(2, :node)))
    end
  end

  specify '#node' do
    expect(graph.query.node(1).id).to eq(1)
  end

  specify '#node#adjacent' do
    expect(graph.query.node(1).adjacent.first.id).to eq(2)
  end
end
