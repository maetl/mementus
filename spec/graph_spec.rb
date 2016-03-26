require 'spec_helper'

describe Mementus::Graph do
  specify '#new' do
    graph = Mementus::Graph.new

    expect(graph.nodes_count).to eq(0)
    expect(graph.edges_count).to eq(0)
  end

  specify '#add_node' do
    graph = Mementus::Graph.new
    graph.add_node(Mementus::Node.new(1, :node))

    expect(graph.nodes_count).to eq(1)
    expect(graph.edges_count).to eq(0)
  end

  specify '#add_edge' do
    graph = Mementus::Graph.new
    graph.add_edge(Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(2, :node)))

    expect(graph.nodes_count).to eq(2)
    expect(graph.edges_count).to eq(1)
  end

  specify '#has_node?' do
    graph = Mementus::Graph.new
    node = Mementus::Node.new(1, :node)
    graph.add_node(node)

    expect(graph.has_node?(node)).to be true
    expect(graph.has_node?(node.dup)).to be false
  end

  specify '#has_edge?' do
    graph = Mementus::Graph.new
    edge = Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(2, :node))
    edge2 = Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(2, :node))
    graph.add_edge(edge)

    expect(graph.has_edge?(edge)).to be true
    expect(graph.has_edge?(edge2)).to be false
  end
end
