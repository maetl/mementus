require 'spec_helper'

describe Mementus::Graph do
  let(:node_1) do
    Mementus::Node.new(id: 1)
  end

  let(:node_2) do
    Mementus::Node.new(id: 2)
  end

  let(:edge_1_2) do
    Mementus::Edge.new(from: node_1, to: node_2)
  end

  specify '#new' do
    graph = Mementus::Graph.new

    expect(graph.nodes_count).to eq(0)
    expect(graph.edges_count).to eq(0)
  end

  specify '#add_node' do
    node = node_1
    graph = Mementus::Graph.new do
      add_node(node)
    end

    expect(graph.nodes_count).to eq(1)
    expect(graph.edges_count).to eq(0)
  end

  specify '#create_node' do
    graph = Mementus::Graph.new do
      create_node do |node|
        node.id = 20
        node.label = :vertex
      end
    end

    expect(graph.nodes_count).to eq(1)
    expect(graph.edges_count).to eq(0)
    expect(graph.node(1).id).to eq(1)
  end

  specify '#add_edge' do
    edge = edge_1_2
    graph = Mementus::Graph.new do
      add_edge(edge)
    end

    expect(graph.nodes_count).to eq(2)
    expect(graph.edges_count).to eq(1)
    expect(graph.node(1).id).to eq(1)
    expect(graph.node(2).id).to eq(2)
  end

  specify '#create_edge' do
    graph = Mementus::Graph.new do
      create_edge do |edge|
        edge.id = 123
        edge.label = :relationship
        edge.from = "A"
        edge.to = "B"
      end
    end

    expect(graph.nodes_count).to eq(2)
    expect(graph.edges_count).to eq(1)
    expect(graph.edge(123).id).to eq(123)
  end

  specify '#has_node?' do
    node = node_1
    graph = Mementus::Graph.new do
      add_node(node)
    end

    expect(graph.has_node?(node_1)).to be true
  end

  specify '#has_edge?' do
    edge = edge_1_2
    graph = Mementus::Graph.new do
      add_edge(edge)
    end

    expect(graph.has_edge?(edge_1_2)).to be true
  end

  specify '#node(id)' do
    edge = edge_1_2
    graph = Mementus::Graph.new do
      add_edge(edge)
    end

    expect(graph.node(1).id).to eq(edge_1_2.from.id)
  end

  specify '#nodes(filter)' do
    edge = edge_1_2
    graph = Mementus::Graph.new do
      add_edge(edge)
    end

    expect(graph.nodes.first.id).to eq(edge_1_2.from.id)
    expect(graph.nodes.last.id).to eq(edge_1_2.to.id)
  end
end
