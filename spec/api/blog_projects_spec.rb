require 'spec_helper'

describe V1::BlogProjects do
  
  # gets array of published BlogProjects
  describe 'GET /api/v1/blog_projects' do
    it 'returns published BlogProjects' do
      bp1 = Fabricate(:blog_project, published: true)
      bp2 = Fabricate(:blog_project, published: false)
      
      get "/api/v1/blog_projects"
      
      hash = JSON.parse(response.body)
      
      ids = hash['blog_projects'].collect { |p| p['id'] }
      ids.should include bp1.id
      ids.should_not include bp2.id
    end
  end

end
