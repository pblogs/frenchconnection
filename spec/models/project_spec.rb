require 'spec_helper'

describe Project do
  before :each do
    @task = Fabricate(:project)
  end
  it "is valid from the Fabric" do
    expect(@task).to be_valid
  end
end
