require 'spec_helper'

describe Mementus::Query do
  let(:graph) do
    Mementus::Graph.new do
      set_edge(Mementus::Edge.new(from: Mementus::Node.new(id: 1),to: Mementus::Node.new(id: 2)))
    end
  end

  specify '#node' do
    expect(graph.query.node(1).id).to eq(1)
  end

  specify '#node#adjacent' do
    expect(graph.query.node(1).adjacent.first.id).to eq(2)
  end
end
