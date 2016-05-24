require 'spec_helper'

describe 'Basic graph traversals' do
  let(:graph) do
    Mementus::Graph.new do
      add_edge(Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(2, :node)))
      add_edge(Mementus::Edge.new(Mementus::Node.new(2, :node), Mementus::Node.new(3, :node)))
      add_edge(Mementus::Edge.new(Mementus::Node.new(2, :node), Mementus::Node.new(5, :node)))
      add_edge(Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(6, :node)))
      add_edge(Mementus::Edge.new(Mementus::Node.new(2, :node), Mementus::Node.new(7, :node)))
      add_edge(Mementus::Edge.new(Mementus::Node.new(7, :node), Mementus::Node.new(8, :node)))
      add_edge(Mementus::Edge.new(Mementus::Node.new(5, :node), Mementus::Node.new(9, :node)))
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
