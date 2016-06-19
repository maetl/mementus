require 'spec_helper'

describe Mementus::Graph do
  specify '#new' do
    graph = Mementus::Graph.new

    expect(graph.nodes_count).to eq(0)
    expect(graph.edges_count).to eq(0)
  end

  specify '#add_node' do
    graph = Mementus::Graph.new do
      add_node(Mementus::Node.new(id: 1, label: :node))
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
    graph = Mementus::Graph.new do
      add_edge(Mementus::Edge.new(Mementus::Node.new(id: 1, label: :node), Mementus::Node.new(id: 2, label: :node)))
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
    node = Mementus::Node.new(id: 1, label: :node)
    graph = Mementus::Graph.new do
      add_node(node)
    end

    expect(graph.has_node?(node)).to be true
  end

  specify '#has_edge?' do
    edge = Mementus::Edge.new(Mementus::Node.new(id: 1, label: :node), Mementus::Node.new(id: 2, label: :node))
    graph = Mementus::Graph.new do
      add_edge(edge)
    end

    expect(graph.has_edge?(edge)).to be true
  end

  specify '#node(id)' do
    edge = Mementus::Edge.new(Mementus::Node.new(id: 1, label: :node), Mementus::Node.new(id: 2, label: :node))
    graph = Mementus::Graph.new do
      add_edge(edge)
    end

    expect(graph.node(1).id).to eq(edge.from.id)
  end

  specify '#nodes(filter)' do
    edge = Mementus::Edge.new(Mementus::Node.new(id: 1, label: :node), Mementus::Node.new(id: 2, label: :node))
    graph = Mementus::Graph.new do
      add_edge(edge)
    end

    expect(graph.nodes.first.id).to eq(edge.from.id)
    expect(graph.nodes.last.id).to eq(edge.to.id)
  end
end
