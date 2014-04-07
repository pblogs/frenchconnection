require 'spec_helper'

describe Paint do
  before :each do
    @paint    = Fabricate(:paint)
  end
  
  it "is valid from the Fabric" do
    expect(@paint).to be_valid
  end
end
