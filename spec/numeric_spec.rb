require 'spec_helper'

describe Numeric do
  it "should include Alchemist" do
    Numeric.should include(Alchemist)
  end
end
