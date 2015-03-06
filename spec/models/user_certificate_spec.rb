require 'spec_helper'

describe UserCertificate do
  before :each do
    @user_certificate    = Fabricate(:user_certificate)
  end

  it "is valid from the Fabric" do
    expect(@user_certificate).to be_valid
  end
end
