require_relative 'mutable_graph_example'

describe Mementus::Structure::AdjacencyList do
  let(:structure) do
    Mementus::Structure::AdjacencyList.new
  end

  it_behaves_like "a mutable graph data structure"
end
