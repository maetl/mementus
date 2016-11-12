require 'spec_helper'

class GraphWrapper
  def one
    111
  end

  def two
    222
  end

  def build
    Mementus::Graph.new do
      add_edge(from: one, to: two)
    end
  end
end

describe Mementus::BindingDelegator do
  it 'dispatches to methods in block scope' do
    graph = GraphWrapper.new.build
    expect(graph.n(111).first.outgoing.first.id).to eq(222)
  end
end
