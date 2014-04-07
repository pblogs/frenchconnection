require 'spec_helper'

describe Task do
  before :each do
    @task    = Fabricate(:task)
  end
  
  it "is valid from the Fabric" do
    expect(@task).to be_valid
  end

  it "has a customer" do
    expect(@task.customer.class).to eq Customer
  end

  it "has a task type" do
    expect(@task.task_type.class).to eq TaskType
  end

  it "belongs to an artisan" do
    expect(@task.artisan.class).to eq Artisan
  end
end
