require 'spec_helper'

describe Department do
  before :each do
    @department = Fabricate(:department)
  end
  
  it "is valid from the Fabric" do
    expect(@department).to be_valid
  end
end
