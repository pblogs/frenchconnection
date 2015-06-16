# == Schema Information
#
# Table name: user_certificates
#
#  id             :integer          not null, primary key
#  certificate_id :integer
#  user_id        :integer
#  image          :string
#  expiry_date    :date
#

require 'spec_helper'

describe UserCertificate do
  before :each do
    @user_certificate    = Fabricate(:user_certificate)
  end

  it "is valid from the Fabric" do
    expect(@user_certificate).to be_valid
  end
end
