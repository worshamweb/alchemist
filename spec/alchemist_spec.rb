require 'alchemist'

describe Alchemist do

  it "validates equivalency" do
    1.m.should === 1.meter
  end
  
  it "validates bits and bytes" do
    65.bit.to_f.should ===  (1.bit + 8.bytes).to_f
    0.125.bytes.to_f.should === 1.bit.to.bytes.to_f
    1.MB.to.kB.to_f.should be_within(1e-5).of(1024.0)
    1.MB.to.b.to_f.should be_within(1e-5).of(8388608.0)
    1.GB.to.B.to_f.to_f.should be_within(1e-5).of(1073741824.0)
    1.MiB.to.KiB.to_f.should be_within(1e-5).of(1024.0)
    1.MiB.to.b.to_f.should be_within(1e-5).of(8388608.0)
    1.GiB.to.B.to_f.should be_within(1e-5).of(1073741824.0)
    Alchemist::use_si = true
    1.GB.to.B.to_f.should be_within(1e-5).of(1000000000.0)
    1.MB.to.b.to_f.should be_within(1e-5).of(8000000.0)
    1.MB.to.kB.to_f.should be_within(1e-5).of(1000.0)
  end
  
  it "validates miles.to.feet" do
    5280.feet.should === 1.miles.to.feet 
  end
  
  it "validates acres.to.square_yards" do
    1.acre.to.square_yards.to_f.should be_within(1e-5).of(4840.square_yards.to_f)
    #assert_in_delta(4840.square_yards.to_f,  1.acre.to.square_yards.to_f, 1e-5)
  end
  
  it "validates gallons.to.L" do
    #assert_in_delta( 3.785411784.L.to_f, 1.gallons.to.L.to_f, 1e-5 )
    1.gallons.to.L.to_f.should be_within(1e-5).of(3.785411784.L.to_f)
  end
  
  it "validates lb.to.kg" do
    0.45359237.kg.to_f.should === 1.lb.to.kg.to_f 
  end
  
  it "validates comparison" do
    5.grams.should === 0.005.kilograms
  end
  
  it "validates register" do
    Alchemist.register(:distance, [:beard_second, :beard_seconds], 5.angstroms)
    1.beard_second.should === 5.angstroms
    Alchemist.register(:temperature, :yeti, [Proc.new{|t| t + 1}, Proc.new{|t| t - 1}])
    0.yeti.should === 1.kelvin
  end
  
  it "validates square meters" do
    (1.meter * 1.meter).should === 1.square_meter
  end
  
  it "validates cubic meters" do
    (1.meter * 2.meter * 3.meter).should === 6.cubic_meters
    (2.square_meters * 3.meters).should === 6.cubic_meters
  end
  
  it "validates division of values" do
    (2.meters / 1.meters).should === 2.0
  end
  
  it "validates temperature conversion" do
    0.celsius.to.fahrenheit.round.should === 32
    32.fahrenheit.to.celsius.round.should === 0
  end
  
  it "validates density" do
    25.brix.to_f.should === 1.1058.sg.to.brix.round(1)
    25.brix.to.baume.round(2).should === 13.87
    25.plato.should === 25.125.brix
  end
  
end
