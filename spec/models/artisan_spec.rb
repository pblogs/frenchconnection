require 'spec_helper'

describe Artisan do
  before :each do
    @artisan  = Fabricate(:artisan)
  end

  it "is valid from the Fabric" do
    expect(@artisan).to be_valid
  end

  it "an artisan can have many tasks" do
    @task = Fabricate(:task)
    @task2 = Fabricate(:task)
    @artisan.tasks << @task
    @artisan.tasks << @task2
    expect(@artisan.tasks).to include(@task, @task2)
  end
end
