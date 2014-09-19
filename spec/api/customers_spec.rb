require 'spec_helper'

describe V1::Customers do

  describe 'GET /api/v1/customers/:id' do
    it 'get a customer' do
      customer = Fabricate(:customer, name: 'Blokka')
      get "/api/v1/customers/#{ customer.id }"
      hash = JSON.parse(response.body)
      hash['customers']['name'].should eq 'Blokka'
    end
  end

  describe 'GET /api/v1/customers/:id/projects' do
    it 'gets a customers projects' do
      customer = Fabricate(:customer, name: 'Blokka')
      Fabricate(:project, customer: customer, name: 'New fences')
      Fabricate(:project, customer: customer, name: 'New roof')
      get "/api/v1/customers/#{ customer.id }/projects"
      response.status.should == 200
      hash = JSON.parse(response.body)
      hash['projects'].first['name'].should eq 'New fences'
      hash['projects'].last['name'].should eq 'New roof'
    end
  end
end

