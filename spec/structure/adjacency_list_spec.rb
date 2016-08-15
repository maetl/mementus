require_relative 'indexed_graph_example'

describe Mementus::Structure::AdjacencyList do
  let(:structure) do
    Mementus::Structure::AdjacencyList.new
  end

  it_behaves_like 'an indexed graph data structure'
end
