require 'spec_helper'

describe Alchemist::Definition do
  subject { Alchemist::Definition.new(:length, :meter, 1) }

  its(:measurement) { should == :length }
  its(:name) { should == :meter }
  its(:value) { should == 1 }
  its(:short_names) { should == [] }
  its(:aliases) { should == {} }

end

describe Alchemist::Definition, 'plural' do
  subject { Alchemist::Definition.new(:length, :meter, 1) }
  before { subject.plural('meters') }
  its(:plural_name) { should == 'meters' }
end

describe Alchemist::Definition, 'short' do
  subject { Alchemist::Definition.new(:length, :meter, 1) }
  before { subject.short('m') }
  its(:short_names) { should =~ ['m'] }
end

describe Alchemist::Definition, 'add_alias' do
  subject { Alchemist::Definition.new(:length, :meter, 1) }

  context "with value" do
    before { subject.add_alias(:metre) }
    its(:aliases) { should == { :metre => :metre } }
  end

  context "with hash" do
    before { subject.add_alias(:metre => :metres) }
    its(:aliases) { should == { :metre => :metres } }
  end

end

describe Alchemist::Definition, 'each_name' do
  subject { Alchemist::Definition.new(:length, :meter, 1) }
  before do
    subject.plural :meters
    subject.short :m
    subject.add_alias :metre => :metres
  end

  it "yields all names" do
    names = []
    subject.each_name do |name|
      names << name
    end
    names.should =~ [:meter, :meters, :m, :metre, :metres]
  end
end
