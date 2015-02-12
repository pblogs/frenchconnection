require 'spec_helper'

describe V1::Skills do
  
  describe 'GET /api/v1/skills/:user_id' do
    it "returns a user's skills" do
      Skill.destroy_all
      user = Fabricate(:user)
      skill1 = Fabricate(:skill, title: 'Skill 1')
      skill2 = Fabricate(:skill, title: 'Skill 2')
      user.skills << skill1
      user.save
      get "/api/v1/skills/#{ user.id }"
      hash = JSON.parse(response.body)
      hash['skills'].length.should eq 1
      hash['skills'].first['title'].should eq 'Skill 1'
    end
  end
  
end
