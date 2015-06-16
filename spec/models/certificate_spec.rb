# == Schema Information
#
# Table name: certificates
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Certificate do
  i = Fabricate.sequence(:name)
  let(:driving_licence) { Fabricate(:certificate, title: "Driving licence #{i}") }
  let(:user) { Fabricate(:user) }
  let(:user_certificate) { Fabricate(:user_certificate,
                                     certificate: driving_licence,
                                     user: user) }

  it 'a user has a certificate' do
    user_certificate.save
    user.certificates.first.should eq driving_licence
  end

  it 'list which users that has a certificate' do
    user_certificate.save
    driving_licence.users.first.should eq user
  end
end
