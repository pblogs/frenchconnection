require 'spec_helper'

describe V1::Certificates do

  describe 'GET /api/v1/certificates/:user_id' do
    it "returns a user's certificates" do
      Certificate.destroy_all
      user = Fabricate(:user)
      cert1 = Fabricate(:certificate, title: 'Cert 1')
      cert2 = Fabricate(:certificate, title: 'Cert 2')
      user_certificate = Fabricate(:user_certificate, user: user,
                                   certificate: cert1)
      user.save
      get "/api/v1/certificates/#{ user.id }"
      hash = JSON.parse(response.body)
      hash['certificates'].length.should eq 1
      hash['certificates'].first['title'].should eq 'Cert 1'
    end
  end

end
