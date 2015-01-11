# == Schema Information
#
# Table name: certificates
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Certificate do
  let(:driving_licence) { Fabricate(:certificate, title: 'Driving licence') }
  let(:user) { Fabricate(:user, certificates: [driving_licence]) }

  it 'a user has a certificate' do
    user.certificates.first.should eq driving_licence
  end

  it 'list which users that has a certificate' do
    driving_licence.users.should eq [user]
  end
end
