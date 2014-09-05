require 'spec_helper'

describe Change do
  before :each do
    @change  = Fabricate(:change)
  end

  it "is valid from the Fabric" do
    expect(@change).to be_valid
  end
end
