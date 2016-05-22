require 'spec_helper'

describe Mementus::Graph do
  let(:graph) do

  end

  specify '#new' do
    graph = Mementus::Graph.new

    expect(graph.nodes_count).to eq(0)
    expect(graph.edges_count).to eq(0)
  end

  specify '#add_node' do
    graph = Mementus::Graph.new do
      add_node(Mementus::Node.new(1, :node))
    end

    expect(graph.nodes_count).to eq(1)
    expect(graph.edges_count).to eq(0)
  end

  specify '#create_node' do
    graph = Mementus::Graph.new do
      create_node do |node|
        node.id = 1
        node.label = :vertex
      end
    end

    expect(graph.nodes_count).to eq(1)
    expect(graph.edges_count).to eq(0)
  end

  specify '#add_edge' do
    graph = Mementus::Graph.new do
      add_edge(Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(2, :node)))
    end

    expect(graph.nodes_count).to eq(2)
    expect(graph.edges_count).to eq(1)
  end

  specify '#create_edge' do
    graph = Mementus::Graph.new do
      create_edge do |edge|
        edge.label = :relationship
        edge.from = "A"
        edge.to = "B"
      end
    end

    expect(graph.nodes_count).to eq(2)
    expect(graph.edges_count).to eq(1)
  end

  specify '#has_node?' do
    node = Mementus::Node.new(1, :node)
    graph = Mementus::Graph.new do
      add_node(node)
    end

    expect(graph.has_node?(node)).to be true
    expect(graph.has_node?(node.dup)).to be false
  end

  specify '#has_edge?' do
    edge = Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(2, :node))
    edge2 = Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(2, :node))

    graph = Mementus::Graph.new do
      add_edge(edge)
    end

    expect(graph.has_edge?(edge)).to be true
    expect(graph.has_edge?(edge2)).to be false
  end

  specify '#node(id)' do
    edge = Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(2, :node))
    graph = Mementus::Graph.new do
      add_edge(edge)
    end

    expect(graph.node(1)).to eq(edge.from)
  end

  specify '#nodes(filter)' do
    edge = Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(2, :node))
    graph = Mementus::Graph.new do
      add_edge(edge)
    end

    expect(graph.nodes).to eq([edge.from, edge.to])
  end
end
