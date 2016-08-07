require 'spec_helper'

describe 'pipeline api' do
  let(:graph) do
    Mementus::Graph.new do
      create_node do |node|
        node.id = 1
        node.label = :passage
        node.props[:name] = 'one'
      end

      create_node do |node|
        node.id = 2
        node.label = :passage
        node.props[:name] = 'two'
      end

      create_node do |node|
        node.id = 4
        node.label = :passage
        node.props[:name] = 'three'
      end

      create_edge do |edge|
        edge.id = 3
        edge.from = 1
        edge.to = 2
        edge.label = :choice
      end

      create_edge do |edge|
        edge.id = 5
        edge.from = 2
        edge.to = 4
        edge.label = :choice
      end
    end
  end

  it 'traverses from the given node id' do
    pipeline = graph.n(1)
    expect(pipeline.id).to eq(1)
    expect(pipeline.first.id).to eq(1)
  end

  it 'traverses from the given node match' do
    pipeline = graph.n(name: 'one')
    expect(pipeline.id).to eq(1)
    expect(pipeline.first.id).to eq(1)
  end

  it 'traverses to outgoing nodes' do
    pipeline = graph.n(1).out
    expect(pipeline.all.count).to eq(1)
    expect(pipeline.all.first.id).to eq(2)
  end

  it 'traverses to second-degree outgoing nodes' do
    pipeline = graph.n(1).out.out
    expect(pipeline.all.count).to eq(1)
    expect(pipeline.all.first.id).to eq(4)
  end

  it 'traverses to outgoing edges' do
    pipeline = graph.n(1).out_e
    expect(pipeline.all.count).to eq(1)
    expect(pipeline.all.first.to.id).to eq(2)
  end

  it 'traverses to incoming nodes' do
    pipeline = graph.n(2).in
    expect(pipeline.all.count).to eq(1)
    expect(pipeline.all.first.id).to eq(1)
  end

  it 'traverses to incoming edges' do
    pipeline = graph.n(2).in_e
    expect(pipeline.all.count).to eq(1)
    expect(pipeline.all.first.from.id).to eq(1)
  end
end
