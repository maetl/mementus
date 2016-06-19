require 'spec_helper'

describe 'Basic graph traversals' do
  let(:graph) do
    Mementus::Graph.new do
      add_edge(Mementus::Edge.new(Mementus::Node.new(id: 1, label: :node), Mementus::Node.new(id: 2, label: :node)))
      add_edge(Mementus::Edge.new(Mementus::Node.new(id: 2, label: :node), Mementus::Node.new(id: 3, label: :node)))
      add_edge(Mementus::Edge.new(Mementus::Node.new(id: 2, label: :node), Mementus::Node.new(id: 5, label: :node)))
      add_edge(Mementus::Edge.new(Mementus::Node.new(id: 1, label: :node), Mementus::Node.new(id: 6, label: :node)))
      add_edge(Mementus::Edge.new(Mementus::Node.new(id: 2, label: :node), Mementus::Node.new(id: 7, label: :node)))
      add_edge(Mementus::Edge.new(Mementus::Node.new(id: 7, label: :node), Mementus::Node.new(id: 8, label: :node)))
      add_edge(Mementus::Edge.new(Mementus::Node.new(id: 5, label: :node), Mementus::Node.new(id: 9, label: :node)))
    end
  end

  specify 'DepthFirstSearch#each' do
    traversal = Mementus::DepthFirstSearch.new(graph, 1)

    expected = [2,3,5,9,7,8,6]
    actual = []
    traversal.each { |n| actual << n.id }

    expect(actual).to eq(expected)
  end

  specify 'BreadthFirstSearch#each' do
    traversal = Mementus::BreadthFirstSearch.new(graph, 1)

    expected = [2,6,3,5,7,9,8]

    actual = []
    traversal.each { |n| actual << n.id }

    expect(actual).to eq(expected)
  end
end
