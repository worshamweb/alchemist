require 'spec_helper'

describe Alchemist, 'definition' do
  let(:definition) { Alchemist::Definition.new(:length, :meter, 1) }
  before { Alchemist.create_measurements(definition) }

  it "returns an Alchemist::Definition" do
    Alchemist.definition(:meter).should be_a(Alchemist::Definition)
  end

end

describe Alchemist, 'define' do
  let!(:transmutator) { "foo" }
  let(:meter_definition) { Alchemist::Definition.new(:length, :meter, 1) }
  let(:foot_definition) { Alchemist::Definition.new(:length, :foot, 0.3048) }

  it "evaluates the block on an Alchemist::Transmutator" do
    transmutator.stubs(:bar)
    transmutator.stubs(:define_methods)
    transmutator.stubs(:definitions).returns([])
    Alchemist::Transmutator.stubs(:new).returns(transmutator)
    block = lambda { bar }
    Alchemist.define(:length, &block)
    Alchemist::Transmutator.should have_received(:new).with(:length)
    transmutator.should have_received(:bar)
  end

  it "creates measurements for each definition" do
    transmutator.stubs(:definitions).returns([meter_definition, foot_definition])
    Alchemist::Transmutator.stubs(:new).returns(transmutator)
    Alchemist.stubs(:create_measurements)
    Alchemist.define(:length)
    Alchemist.should have_received(:create_measurements).with(meter_definition)
    Alchemist.should have_received(:create_measurements).with(foot_definition)
  end

  it "create measurement methods for each definition" do
    transmutator.stubs(:definitions).returns([meter_definition, foot_definition])
    Alchemist::Transmutator.stubs(:new).returns(transmutator)
    Alchemist.stubs(:create_measurement_methods)
    Alchemist.define(:length)
    Alchemist.should have_received(:create_measurement_methods).with(meter_definition)
    Alchemist.should have_received(:create_measurement_methods).with(foot_definition)
  end
end

describe Alchemist, 'create_measurements' do
  let(:definition) { Alchemist::Definition.new(:length, :meter, 1) }
  before do
    definition.stubs(:each_name).multiple_yields(:meter, :meters)
  end
  it "defines the measurements" do
    Alchemist.create_measurements(definition)
    Alchemist.definition(:meter).should == definition
    Alchemist.definition(:meters).should == definition
  end
end

describe Alchemist, 'create_measurement_methods' do
  let(:definition) { Alchemist::Definition.new(:length, :meter, 1) }
  before do
    definition.stubs(:each_name).multiple_yields(:meter, :meters)
  end
  it "defines the methods" do
    Alchemist.create_measurement_methods(definition)
    1.should respond_to(:meter)
    1.should respond_to(:meters)
  end
end

describe Alchemist::Transmutator do
  subject { Alchemist::Transmutator.new(:length) }
  its(:definitions) { should == [] }
end

describe Alchemist::Transmutator, 'unit' do

  let(:transmutator) { Alchemist::Transmutator.new(:length) }
  let(:definition) { Alchemist::Definition.new(:length, :meter, 1) }

  before { Alchemist::Definition.stubs(:new).returns(definition) }

  it "Proxies creation to Alchemist" do
    transmutator.unit(:meter, 1)
    transmutator.definitions.should == [definition]
  end

  it "evaluates the block on the definition" do
    definition.stubs(:bar)
    Alchemist.stubs(:define_measurement).returns(definition)
    block = lambda { bar }
    transmutator.unit(:meter, 1, &block)
    definition.should have_received(:bar)
  end

end
