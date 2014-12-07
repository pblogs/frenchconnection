require 'spec_helper'

describe V1::Inventories do
  
  describe 'GET /api/v1/inventories/inventories' do
    it 'lists all inventories' do
      inventory1 = Fabricate(:inventory) 
      inventory2 = Fabricate(:inventory)
      inventory3 = Fabricate(:inventory)
      get "/api/v1/inventories/"
      response.status.should == 200
      hash = JSON.parse(response.body)
      ids = hash['inventories'].collect { |u| u['id'] }
      ids.should =~ [inventory3.id, inventory2.id, inventory1.id] 
    end
  end

  describe 'GET /api/v1/inventories/:inventory_id' do
    it 'lists a specific inventory' do
      inventory = Fabricate(:inventory)
      get "/api/v1/inventories/#{ inventory.id }"
      response.status.should == 200
      hash = JSON.parse(response.body)
      u = hash['inventories']
      u['name'].should eq inventory.name
    end
  end
  
end
