require 'alchemist'

describe Alchemist do
  it "validates compound" do
    30.miles.should === (10.miles.per.second * 3.seconds)
    30.km.should === (10.km.p.h * 3.hours)
    4.m.per.m.should === 4
  end
end
