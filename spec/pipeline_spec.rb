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

  it 'traverses from the given node' do
    pipeline = graph.n(1)
    expect(pipeline.id).to eq(1)
    expect(pipeline.one.id).to eq(1)
  end

  it 'traverses to outgoing nodes' do
    pipeline = graph.n(1).out
    expect(pipeline.all.count).to eq(1)
    expect(pipeline.all.first.id).to eq(2)
  end

  it 'traverses to incoming nodes' do
    pipeline = graph.n(2).in
    expect(pipeline.all.count).to eq(1)
    expect(pipeline.all.first.id).to eq(1)
  end
end
