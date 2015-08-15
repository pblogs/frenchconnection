# == Schema Information
#
# Table name: departments
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Department do
  before :each do
    @department = Fabricate(:department)
  end

  it "is valid from the Fabric" do
    expect(@department).to be_valid
  end
end
