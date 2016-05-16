require 'spec_helper'

describe Mementus::IntegerId do
  it 'counts upwards from 1 by default' do
    generator = Mementus::IntegerId.new
    expect(generator.next_id).to eq(1)
    expect(generator.next_id).to eq(2)
    expect(generator.next_id).to eq(3)
  end

  it 'counts upwards from given start value' do
    generator = Mementus::IntegerId.new(100)
    expect(generator.next_id).to eq(100)
    expect(generator.next_id).to eq(101)
    expect(generator.next_id).to eq(102)
  end
end
