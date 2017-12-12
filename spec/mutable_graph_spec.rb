require 'spec_helper'

describe Mementus::MutableGraph do
  specify '#new' do
    graph = Mementus::MutableGraph.new

    expect(graph.nodes_count).to eq(0)
    expect(graph.edges_count).to eq(0)
  end

  specify '#set_node' do
    graph = Mementus::MutableGraph.new
    graph.set_node(node_1)

    expect(graph.nodes_count).to eq(1)
    expect(graph.edges_count).to eq(0)
  end

  specify '#add_node' do
    graph = Mementus::MutableGraph.new
    graph.add_node(id: 1)

    expect(graph.nodes_count).to eq(1)
    expect(graph.edges_count).to eq(0)
    expect(graph.node(1).id).to eq(1)
  end

  specify '#add_node -> with auto id' do
    graph = Mementus::MutableGraph.new
    graph.add_node

    expect(graph.node(1).id).to eq(1)
  end

  specify '#add_node -> with props' do
    graph = Mementus::MutableGraph.new
    graph.add_node(props: { title: 'Vertex' })

    expect(graph.node(1)[:title]).to eq('Vertex')
  end

  specify '#create_node' do
    graph = Mementus::MutableGraph.new
    graph.create_node do |node|
      node.id = 20
      node.label = :vertex
      node.props[:title] = 'Vertex'
    end

    expect(graph.nodes_count).to eq(1)
    expect(graph.edges_count).to eq(0)

    graph.node(20).tap do |node|
      expect(node.id).to eq(20)
      expect(node.label).to eq(:vertex)
      expect(node[:title]).to eq('Vertex')
    end
  end

  specify '#set_edge' do
    graph = Mementus::MutableGraph.new
    graph.set_edge(edge_1_2)

    expect(graph.nodes_count).to eq(2)
    expect(graph.edges_count).to eq(1)
    expect(graph.node(1).id).to eq(1)
    expect(graph.node(2).id).to eq(2)
  end

  specify '#add_edge' do
    graph = Mementus::MutableGraph.new
    graph.add_edge(id: 3, from: 1, to: 2)

    expect(graph.nodes_count).to eq(2)
    expect(graph.edges_count).to eq(1)
    expect(graph.node(1).id).to eq(1)
    expect(graph.node(2).id).to eq(2)
    expect(graph.edge(3).id).to eq(3)
  end

  specify '#add_edge -> with auto id' do
    graph = Mementus::MutableGraph.new
    graph.add_edge(from: 1, to: 2)

    expect(graph.edge(1).id).to eq(1)
  end

  specify '#add_edge -> with props' do
    graph = Mementus::MutableGraph.new
    graph.add_edge(from: 1, to: 2, props: { title: 'Relationship' })

    expect(graph.edge(1)[:title]).to eq('Relationship')
  end

  specify '#create_edge' do
    graph = Mementus::MutableGraph.new
    graph.create_edge do |edge|
      edge.id = 123
      edge.label = :relationship
      edge.from = 'A'
      edge.to = 'B'
      edge.props[:name] = 'Relationship'
    end

    expect(graph.nodes_count).to eq(2)
    expect(graph.edges_count).to eq(1)

    graph.edge(123).tap do |edge|
      expect(edge.id).to eq(123)
      expect(edge.label).to eq(:relationship)
      expect(edge.from.id).to eq('A')
      expect(edge.to.id).to eq('B')
      expect(edge[:name]).to eq('Relationship')
    end
  end
end
