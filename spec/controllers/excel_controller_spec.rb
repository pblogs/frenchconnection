require 'spec_helper'

describe ExcelController, :type => :controller do
  before do
    @project = Fabricate(:project)
    sign_in
  end

  describe "GET 'export'" do
    it "returns http success" do
      get 'export', project_id: @project.id
      response.should be_success
    end
  end

end
