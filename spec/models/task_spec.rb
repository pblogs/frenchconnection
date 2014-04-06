require 'spec_helper'

describe Task do
  before :each do
    @task    = Fabricate(:task)
  end
  
  it "is valid from the Fabric" do
    expect(@task).to be_valid
  end
end
