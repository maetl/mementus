require 'spec_helper'

describe Mementus::DepthFirstSearch do
  specify '#each' do
    graph = Mementus::Graph.new
    start = Mementus::Node.new(1, :node)
    graph.add_edge(Mementus::Edge.new(start, Mementus::Node.new(2, :node)))
    graph.add_edge(Mementus::Edge.new(Mementus::Node.new(2, :node), Mementus::Node.new(3, :node)))
    graph.add_edge(Mementus::Edge.new(Mementus::Node.new(2, :node), Mementus::Node.new(5, :node)))
    graph.add_edge(Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(6, :node)))
    graph.add_edge(Mementus::Edge.new(Mementus::Node.new(2, :node), Mementus::Node.new(7, :node)))
    graph.add_edge(Mementus::Edge.new(Mementus::Node.new(7, :node), Mementus::Node.new(8, :node)))
    graph.add_edge(Mementus::Edge.new(Mementus::Node.new(5, :node), Mementus::Node.new(9, :node)))

    traversal = Mementus::DepthFirstSearch.new(graph, start)

    expected = [1,2,3,5,9,7,8,6]
    index = 0
    traversal.each do |node|
      expect(node.id).to eq(expected[index + 1])
    end
  end
end
