require 'spec_helper'

describe Mementus::Direction do
  specify 'incoming const' do
    expect(Mementus::Direction::IN).to eq(:in)
  end

  specify 'outgoing const' do
    expect(Mementus::Direction::OUT).to eq(:out)
  end

  specify 'bidirectional const' do
    expect(Mementus::Direction::BOTH).to eq(:both)
  end

  specify 'incoming flips to outgoing' do
    expect(Mementus::Direction.flip(:in)).to eq(:out)
  end

  specify 'outgoing flips to incoming' do
    expect(Mementus::Direction.flip(:out)).to eq(:in)
  end

  specify 'bidirectional does not flip' do
    expect(Mementus::Direction.flip(:both)).to eq(:both)
  end
end
