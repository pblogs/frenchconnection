# == Schema Information
#
# Table name: task_types
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe TaskType do
  before :each do
    @task_type = Fabricate(:task_type)
  end

  it "is valid from the Fabric" do
    expect(@task_type).to be_valid
  end
end
