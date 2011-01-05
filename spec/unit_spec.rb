require 'spec_helper'

describe Alchemist::Unit do
  let(:definition) { Alchemist::Definition.new(:length, :meter, 1) }
  subject { Alchemist::Unit.new(definition, 1) }

  its(:definition) { should == definition }
  its(:value) { should == 1 }

  it "is comparable" do
    Alchemist::Unit.should include(Comparable)
  end

end

describe Alchemist::Unit, "to" do
  context "with unit" do
    before do
      Alchemist.define(:length) do
        unit :meter, 1
        unit :foot, 0.3048
      end
    end

    it "converts the unit" do
      1.meter.to(:foot).should == 3.2808399.foot
    end
  end
end
