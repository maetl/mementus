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

  describe '#new' do
    it 'treats steps as enumerable sources to other steps' do
      step = Mementus::Pipeline::Step.new(Mementus::Pipeline::Step.new([:a, :b, :c]))
      expect(step.all).to eq([:a, :b, :c])
    end

    it 'transforms output values based on the given pipe' do
      transform = -> (value) { Fiber.yield(value.to_s.upcase) }
      step = Mementus::Pipeline::Step.new([:a, :b, :c], transform)
      expect(step.all).to eq(['A', 'B', 'C'])
    end

    it 'filters output values based on the given pipe' do
      filter = -> (value) { Fiber.yield(value) if value == :a }
      step = Mementus::Pipeline::Step.new([:a, :b, :c], filter)
      expect(step.all).to eq([:a])
    end

    it 'transforms and filters output values based on the given pipes' do
      filter = -> (value) { Fiber.yield(value) if value == :a }
      transform = -> (value) { Fiber.yield(value.to_s.upcase) }
      prev = Mementus::Pipeline::Step.new([:a, :b, :c], filter)
      step = Mementus::Pipeline::Step.new(prev, transform)
      expect(step.all).to eq(['A'])
    end
  end
end
