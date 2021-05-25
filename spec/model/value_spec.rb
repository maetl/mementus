describe Mementus::Model::Value do
  Value = Mementus::Model::Value

  it "empty definition error" do
    expect { Value.new }.to raise_error(ArgumentError)
  end

  it "constructs immutable struct" do
    Color = Value.new(:name)
    teal = Color.new(name: "teal")
    expect { teal.name = "turquoise" }.to raise_error(FrozenError)
  end

  it "builds struct from slot declaration" do
    Slots = Value.new(:first, :last)
    slots = Slots.new(first: "hello", last: "world")
    expect(slots.first).to eq("hello")
    expect(slots.last).to eq("world")
  end

  it "builds struct from field declaration" do
    Fields = Value.new(name: String, email: String)
    fields = Fields.new(name: "maetl", email: "me@maetl.net")
    expect(fields.name).to eq("maetl")
    expect(fields.email).to eq("me@maetl.net")
  end

  it "compares by value" do
    Weight = Value.new(:value, :unit)
    w1 = Weight.new(value: 50, unit: "kgs")
    w2 = Weight.new(value: 50, unit: "kgs")
    expect(w1 == w2).to be(true)
    expect(w1 === w2).to be(true)
    expect(w1).to eq(w2)
  end

  it "supports ruby struct initializer" do
    Length = Value.new(:size, :unit)
    len = Length.new(500, "cm")
    expect(len.size).to eq(500)
    expect(len.unit).to eq("cm")
  end
end
