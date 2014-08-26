require 'spec_helper'

describe Category do
  before :each do
    @category  = Fabricate(:category)
  end

  it "is valid from the Fabric" do
    expect(@category).to be_valid
  end

  it "contains many projects" do
    @project = Fabricate(:project, category: @category)
    @project.category.should eq @category
  end


end
