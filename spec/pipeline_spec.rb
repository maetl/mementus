require 'spec_helper'

describe 'pipeline api' do
  let(:graph) do
    Mementus::Graph.new do
      create_node do |node|
        node.id = 1
        node.label = :passage
      end

      create_node do |node|
        node.id = 2
        node.label = :passage
      end

      create_edge do |edge|
        edge.id = 3
        edge.from = 1
        edge.to = 2
        edge.label = :choice
      end
    end
  end

  it 'starts a traversal from the given node' do
    pipeline = graph.n(1)
    expect(pipeline.id).to eq(1)
    expect(pipeline.one.id).to eq(1)
  end

  it 'traverses to adjacent nodes' do
    pipeline = graph.n(1).out
    expect(pipeline.all.count).to eq(1)
    expect(pipeline.all.first.id).to eq(2)
  end
end
