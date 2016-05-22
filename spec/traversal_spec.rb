require 'spec_helper'

describe 'Basic graph traversals' do
  let(:start) do
    Mementus::Node.new(1, :node)
  end

  let(:graph) do
    start_node = start
    graph = Mementus::Graph.new do
      add_edge(Mementus::Edge.new(start_node, Mementus::Node.new(2, :node)))
      add_edge(Mementus::Edge.new(Mementus::Node.new(2, :node), Mementus::Node.new(3, :node)))
      add_edge(Mementus::Edge.new(Mementus::Node.new(2, :node), Mementus::Node.new(5, :node)))
      add_edge(Mementus::Edge.new(Mementus::Node.new(1, :node), Mementus::Node.new(6, :node)))
      add_edge(Mementus::Edge.new(Mementus::Node.new(2, :node), Mementus::Node.new(7, :node)))
      add_edge(Mementus::Edge.new(Mementus::Node.new(7, :node), Mementus::Node.new(8, :node)))
      add_edge(Mementus::Edge.new(Mementus::Node.new(5, :node), Mementus::Node.new(9, :node)))
    end
  end

  specify 'DepthFirstSearch#each' do
    traversal = Mementus::DepthFirstSearch.new(graph, start)

    expected = [1,2,3,5,9,7,8,6]
    index = 0
    traversal.each do |node|
      expect(node.id).to eq(expected[index + 1])
    end
  end

  specify 'BreadthFirstSearch#each' do
    traversal = Mementus::DepthFirstSearch.new(graph, start)

    expected = [1,2,6,3,5,7,9,8]
    index = 0
    traversal.each do |node|
      expect(node.id).to eq(expected[index + 1])
    end
  end
end
