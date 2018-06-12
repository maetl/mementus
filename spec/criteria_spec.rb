require 'spec_helper'

describe Mementus::Criteria do
  specify 'empty match' do
    match = Mementus::Criteria.new
    expect(match.empty?).to eq(true)
  end

  specify 'non-empty match' do
    match = Mementus::Criteria.new(1)
    expect(match.empty?).to eq(false)
  end

  specify 'match by id' do
    match = Mementus::Criteria.new(1)
    expect(match.id).to eq(1)
  end

  specify 'match by label' do
    match = Mementus::Criteria.new(:entry)
    expect(match.label).to eq(:entry)
  end

  specify 'match by prop equals' do
    match = Mementus::Criteria.new(name: 'hello')
    expect(match.props).to eq(name: 'hello')
  end

  specify 'match by label and prop' do
    match = Mementus::Criteria.new(:entry, name: 'hello')
    expect(match.label).to eq(:entry)
    expect(match.props).to eq(name: 'hello')
  end

  specify 'match by prop and label' do
    match = Mementus::Criteria.new({name: 'hello'}, :entry)
    expect(match.label).to eq(:entry)
    expect(match.props).to eq(name: 'hello')
  end
end
