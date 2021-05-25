describe Mementus::Model::Validator do
  Validator = Mementus::Model::Validator
  Type = Mementus::Model::Type

  describe "schema with optional fields using any type" do
    let(:anchor) do
      Validator.new({
        :href => String,
        :title => Type::Any,
        :target => Type::Any
      })
    end

    specify "hash of attributes" do
      expect(
        anchor.check({:href => "https://maetl.net", :title => "maetl", :target => "_blank"})
      ).to be_truthy
    end

    specify "skip any type attributes when not provided" do
      expect(anchor.check({:href => "https://maetl.net"})).to be_truthy
    end

    specify "missing attribute error" do
      expect {
        anchor.check({})
      }.to raise_error("wrong number of args")
    end

    specify "mismatching attribute error" do
      expect {
        anchor.check({:href => "https://maetl.net", :src => "https://maetl.net"})
      }.to raise_error("key does not exist")
    end
  end

  describe "type constraint schema" do
    let(:rect) do
      Validator.new({
        :shape => String,
        :x => Integer,
        :y => Integer,
        :w => Integer,
        :h => Integer
      })
    end

    specify "checks a flat set of attributes" do
      expect(
        rect.check({:shape => "rect", :x => 10, :y => 10, :w => 64, :h => 48})
      ).to be_truthy
    end

    specify "missing attribute error" do
      expect {
        rect.check({:shape => "rect"})
      }.to raise_error("wrong number of args")
    end

    specify "bad key error" do
      expect {
        rect.check({:mishape => "rect", :shape => "rect", :x => 10, :y => 10, :w => 64, :h => 48})
      }.to raise_error("key does not exist")
    end

    specify "mismatching type error" do
      expect {
        rect.check({:shape => "rect", :x => "1", :y => "1", :w => "1", :h => "1"})
      }.to raise_error("wrong data type")
    end
  end
end
