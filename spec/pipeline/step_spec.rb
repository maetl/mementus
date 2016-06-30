require 'spec_helper'

describe Mementus::Pipeline::Step do
  describe '#each' do
    it 'iterates with an enumerator' do
      enum = Mementus::Pipeline::Step.new([:a, :b, :c]).each
      expect(enum.next).to eq(:a)
      expect(enum.next).to eq(:b)
      expect(enum.next).to eq(:c)
    end

    it 'iterates with a block' do
      Mementus::Pipeline::Step.new([:a]).each do |value|
        expect(value).to eq(:a)
      end
    end

    it 'raises StopIteration when no more values can be yielded' do
      enum = Mementus::Pipeline::Step.new([]).each
      expect { enum.next }.to raise_error(StopIteration)
    end
  end

  describe '#first' do
    it 'returns the first element in the source sequence' do
      step = Mementus::Pipeline::Step.new([:a, :b, :c])
      expect(step.first).to eq(:a)
    end
  end

  describe '#all' do
    it 'returns all values in the source sequence' do
      step = Mementus::Pipeline::Step.new([:a, :b, :c])
      expect(step.all).to eq([:a, :b, :c])
    end
  end

  describe '#take' do
    it 'returns the given number of values from the source sequence' do
      step = Mementus::Pipeline::Step.new([:a, :b, :c])
      expect(step.take(2)).to eq([:a, :b])
    end
  end
end
