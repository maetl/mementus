require 'rspec'
require 'mementus'
require 'mementus/library'

def node_1
  Mementus::Node.new(id: 1)
end

def node_2
  Mementus::Node.new(id: 2)
end

def node_3
  Mementus::Node.new(id: 2)
end

def edge_1_2
  Mementus::Edge.new(from: node_1, to: node_2)
end

def edge_1_3
  Mementus::Edge.new(from: node_1, to: node_3)
end
