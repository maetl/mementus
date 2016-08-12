require_relative 'mutable_graph_example'
require_relative 'property_graph_example'

describe Mementus::Structure::IncidenceList do
  let(:structure) do
    Mementus::Structure::IncidenceList.new
  end

  it_behaves_like 'a mutable graph data structure'
  it_behaves_like 'a property graph data structure'
end
