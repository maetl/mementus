require 'spec_helper'

describe Mementus::Edge do
  it 'should initialize with integer ids' do
    edge = Mementus::Edge.new(from: 1, to: 2)

    expect(edge.from).to be_a(Mementus::Node)
    expect(edge.from.id).to eq(1)
    expect(edge.to).to be_a(Mementus::Node)
    expect(edge.to.id).to eq(2)
  end

  it 'should initialize with node instances' do
    edge = Mementus::Edge.new(from: Mementus::Node.new(id: 1), to: Mementus::Node.new(id: 2))

    expect(edge.from).to be_a(Mementus::Node)
    expect(edge.from.id).to eq(1)
    expect(edge.to).to be_a(Mementus::Node)
    expect(edge.to.id).to eq(2)
  end

  it 'should initialize with label given' do
    edge = Mementus::Edge.new(from: 1, to: 2, label: :relationship)

    expect(edge.label).to eq(:relationship)
  end

  it 'returns nil when missing prop is accessed' do
    edge = Mementus::Edge.new(from: 1, to: 2)

    expect(edge[:title]).to be_nil
  end

  it 'initializes with props given' do
    edge = Mementus::Edge.new(from: 1, to: 2, props: { :title => 'Relationship' })

    expect(edge[:title]).to eq('Relationship')
  end

  it 'does not allow mutation of props' do
    node = Mementus::Edge.new(from: 1, to: 2, props: { title: 'Relationship' })

    expect { node[:title] = 'Edge' }.to raise_error(NoMethodError)
  end

  it 'should test equality based on value' do
    edge1 = Mementus::Edge.new(from: 1, to: 2, label: :relationship)
    edge2 = Mementus::Edge.new(from: 1, to: 2, label: :relationship)

    expect(edge1).to eq(edge2)
    expect(edge1.hash).to eq(edge2.hash)
  end
end
