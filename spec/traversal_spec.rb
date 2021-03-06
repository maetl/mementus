require 'spec_helper'

describe 'Basic graph traversals' do
  let(:graph) do
    Mementus::Graph.new do
      set_edge(Mementus::Edge.new(from: Mementus::Node.new(id: 1), to: Mementus::Node.new(id: 2)))
      set_edge(Mementus::Edge.new(from: Mementus::Node.new(id: 2), to: Mementus::Node.new(id: 3)))
      set_edge(Mementus::Edge.new(from: Mementus::Node.new(id: 2), to: Mementus::Node.new(id: 5)))
      set_edge(Mementus::Edge.new(from: Mementus::Node.new(id: 1), to: Mementus::Node.new(id: 6)))
      set_edge(Mementus::Edge.new(from: Mementus::Node.new(id: 2), to: Mementus::Node.new(id: 7)))
      set_edge(Mementus::Edge.new(from: Mementus::Node.new(id: 7), to: Mementus::Node.new(id: 8)))
      set_edge(Mementus::Edge.new(from: Mementus::Node.new(id: 5), to: Mementus::Node.new(id: 9)))
    end
  end

  specify 'DepthFirstSearch#each' do
    traversal = Mementus::DepthFirstSearch.new(graph, 1)

    expected = [1,2,3,5,9,7,8,6]
    actual = []
    traversal.each { |n| actual << n.id }

    expect(actual).to eq(expected)
  end

  specify 'BreadthFirstSearch#each' do
    traversal = Mementus::BreadthFirstSearch.new(graph, 1)

    expected = [1,2,6,3,5,7,9,8]

    actual = []
    traversal.each { |n| actual << n.id }

    expect(actual).to eq(expected)
  end
end
