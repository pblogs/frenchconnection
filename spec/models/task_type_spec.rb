require 'spec_helper'

describe TaskType do
  before :each do
    @task_type    = Fabricate(:task_type)
  end
  
  it "is valid from the Fabric" do
    expect(@task_type).to be_valid
  end
end
