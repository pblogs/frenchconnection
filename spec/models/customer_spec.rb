# == Schema Information
#
# Table name: customers
#
#  id             :integer          not null, primary key
#  name           :string
#  address        :string
#  org_number     :string
#  contact_person :string
#  phone          :string
#  created_at     :datetime
#  updated_at     :datetime
#  customer_nr    :integer
#  area           :string
#  email          :string
#

require 'spec_helper'

describe Customer do
  before :each do
    @customer    = Fabricate(:customer)
  end

  it "is valid from the Fabric" do
    expect(@customer).to be_valid
  end
end
