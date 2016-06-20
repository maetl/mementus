require 'spec_helper'

describe Mementus::Node do
  it 'should initialize with id' do
    node = Mementus::Node.new(id: 22)

    expect(node.id).to eq(22)
  end

  it 'should initialize with id and label' do
    node = Mementus::Node.new(id: 22, label: :vertex)

    expect(node.id).to eq(22)
    expect(node.label).to eq(:vertex)
  end
end
