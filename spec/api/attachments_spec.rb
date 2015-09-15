require 'spec_helper'

describe V1::Certificates do
  
 
  
  describe 'GET /api/v1/attachments/:project_id' do
    it "returns a project's attachments" do
      pending "Fabricate Attachment"
      Attachment.destroy_all
      project = Fabricate(:project)
      another_project = Fabricate(:project)
      attachment1 = Fabricate(:attachment, 
                              description: 'A 1', 
                              attachable_id: project.id,
                              attachable_type: 'Project')
      attachment2 = Fabricate(:attachment, 
                              description: 'A 2', 
                              attachable_id: another_project.id,
                              attachable_type: 'Project')
                              
      get "/api/v1/attachments/#{ project.id }"
      hash = JSON.parse(response.body)
      hash['attachments'].length.should eq 1
      hash['attachments'].first['description'].should eq 'A 2'
    end
  end
  
end
