require 'spec_helper'

describe ExcelController do

  describe "GET 'export'" do
    it "returns http success" do
      get 'export'
      response.should be_success
    end
  end

end