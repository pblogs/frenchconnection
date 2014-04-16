require 'spec_helper'

describe Project do
  before :each do
    @task = Fabricate(:project)
  end
  it "is valid from the Fabric" do
    expect(@task).to be_valid
  end


  it "knows which artisans that are involved" do
    
  end
end
