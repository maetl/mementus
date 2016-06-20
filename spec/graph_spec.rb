require 'spec_helper'

describe Mementus::Graph do
  specify '#new' do
    graph = Mementus::Graph.new

    expect(graph.nodes_count).to eq(0)
    expect(graph.edges_count).to eq(0)
  end

  specify '#set_node' do
    graph = Mementus::Graph.new do
      set_node(node_1)
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
    expect(graph.node(20).id).to eq(20)
  end

  specify '#set_edge' do
    graph = Mementus::Graph.new do
      set_edge(edge_1_2)
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
    graph = Mementus::Graph.new do
      set_node(node_1)
    end

    expect(graph.has_node?(node_1)).to be true
  end

  specify '#has_edge?' do
    graph = Mementus::Graph.new do
      set_edge(edge_1_2)
    end

    expect(graph.has_edge?(edge_1_2)).to be true
  end

  specify '#node(id)' do
    graph = Mementus::Graph.new do
      set_edge(edge_1_2)
    end

    expect(graph.node(1).id).to eq(edge_1_2.from.id)
  end

  specify '#nodes(filter)' do
    graph = Mementus::Graph.new do
      set_edge(edge_1_2)
    end

    expect(graph.nodes.first.id).to eq(edge_1_2.from.id)
    expect(graph.nodes.last.id).to eq(edge_1_2.to.id)
  end
end
