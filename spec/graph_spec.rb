require 'spec_helper'

describe Mementus::Graph do
  let(:graph) do
    Mementus::Graph.new
  end

  specify '#new' do
    expect(graph.nodes_count).to eq(0)
    expect(graph.edges_count).to eq(0)
  end

  specify '#add_node' do
    graph.add_node(Mementus::Node.new(1, :node))

    expect(graph.nodes_count).to eq(1)
    expect(graph.edges_count).to eq(0)
  end

  specify '#create_node' do
    graph.create_node do |node|
      node.id = 1
      node.label = :vertex
    end

    expect(graph.nodes_count).to eq(1)
    expect(graph.edges_count).to eq(0)
  end

  specify '#add_edge' do
    graph.add_edge(Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(2, :node)))

    expect(graph.nodes_count).to eq(2)
    expect(graph.edges_count).to eq(1)
  end

  specify '#create_edge' do
    graph.create_edge do |edge|
      edge.label = :relationship
      edge.from = "A"
      edge.to = "B"
    end

    expect(graph.nodes_count).to eq(2)
    expect(graph.edges_count).to eq(1)
  end

  specify '#has_node?' do
    node = Mementus::Node.new(1, :node)
    graph.add_node(node)

    expect(graph.has_node?(node)).to be true
    expect(graph.has_node?(node.dup)).to be false
  end

  specify '#has_edge?' do
    edge = Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(2, :node))
    edge2 = Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(2, :node))
    graph.add_edge(edge)

    expect(graph.has_edge?(edge)).to be true
    expect(graph.has_edge?(edge2)).to be false
  end

  specify '#node(id)' do
    edge = Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(2, :node))
    graph.add_edge(edge)

    expect(graph.node(1)).to eq(edge.from)
  end

  specify '#nodes(filter)' do
    edge = Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(2, :node))
    graph.add_edge(edge)

    expect(graph.nodes).to eq([edge.from, edge.to])
  end
end
