require 'spec_helper'

describe Mementus::Node do
  it 'initializes with id' do
    node = Mementus::Node.new(id: 22)

    expect(node.id).to eq(22)
  end

  it 'initializes with label' do
    node = Mementus::Node.new(label: :vertex)

    expect(node.label).to eq(:vertex)
  end

  it 'initializes with id and label' do
    node = Mementus::Node.new(id: 22, label: :vertex)

    expect(node.id).to eq(22)
    expect(node.label).to eq(:vertex)
  end

  it 'returns nil when missing prop is accessed' do
    node = Mementus::Node.new

    expect(node[:title]).to be_nil
  end

  it 'initializes with props keys' do
    node = Mementus::Node.new(props: { title: 'Vertex' })

    expect(node[:title]).to eq('Vertex')
  end

  it 'initializes with props hash' do
    node = Mementus::Node.new(props: { title: 'Vertex', count: 10 })

    expect(node.props).to eq({ title: 'Vertex', count: 10 })
  end

  it 'does not allow mutation of props' do
    node = Mementus::Node.new(props: { title: 'Vertex' })

    expect { node[:title] = 'Node' }.to raise_error(NoMethodError)
  end
end
