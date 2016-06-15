describe Mementus::Library::HerschelGraph do
  let(:graph) do
    Mementus::Library::HerschelGraph.instance
  end

  it 'has 11 vertices' do
    expect(graph.nodes_count).to eq(11)
  end

  it 'has 18 edges' do
    expect(graph.edges_count).to eq(18)
  end
end
