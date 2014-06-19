require 'spec_helper'

describe V1::Person do
  describe 'GET /api/v1/users' do
    it 'returns array of users' do
      get '/api/v1/users', {}, https_and_authorization
      response.status.should == 200
      #parse_response_for(:users).should == User.all
    end
  end

  #describe 'GET /api/v1/persons/:id' do
  #  let(:person) { Fabricate :person }

  #  it 'returns that specific person' do
  #    get "/api/v1/persons/#{ person.slug }", {}, https_and_authorization
  #    response.status.should == 200
  #    parse_response_for(:person)['email'].should == person.email
  #  end
  #end

  #describe 'GET /api/v1/persons/:id/ads' do
  #  let(:person) { Fabricate :person }

  #  it 'returns that specific person' do
  #    url = "/api/v1/persons/#{ person.slug }/ads"
  #    get url, {}, https_and_authorization
  #    response.code.should == '200'
  #    parse_response_for(:person)['email'].should == person.email
  #  end

  #  it 'returns array of that persons ads' do
  #    person_ad = Fabricate :ad, person: person
  #    url = "/api/v1/persons/#{ person.slug }/ads"
  #    get url, {}, https_and_authorization
  #    response.code.should == '200'
  #    parse_response_for(:person)['ads'].first['id'].should == person_ad.id.to_s
  #  end
  #end

  #describe 'POST /api/v1/persons' do
  #  context 'with valid params' do
  #    it 'returns the newly created person' do
  #      post '/api/v1/persons', { person: valid_params }, https_and_authorization
  #      response.code.should == '201'
  #      parse_response_for(:person)['email'].should == valid_params[:email]
  #    end
  #  end

  #  context 'with invalid params' do
  #    it 'returns validation message' do
  #      params = { full_name: 'Ola Nordmann', password: 'testtest' }
  #      post '/api/v1/persons', { person: params }, https_and_authorization
  #      response.code.should == '400'
  #      parse_response_for(:error).should == 'person[email] is missing'
  #    end
  #  end
  #end

  #describe 'PUT /api/v1/persons/:id' do
  #  let(:existing_person) { Fabricate(:person) }

  #  context 'with valid params' do
  #    it 'returns the newly updated person' do
  #      url = "/api/v1/persons/#{ existing_person.slug }"
  #      put url, { person: valid_params }, https_and_authorization
  #      response.code.should == '200'
  #      parsed_response = parse_response_for(:person)
  #      parsed_response['first_name'].should == valid_first_name
  #      parsed_response['last_name'].should  == valid_last_name
  #    end
  #  end

  #  context 'with invalid params' do
  #    it 'returns error message' do
  #      params = {
  #        full_name: 'requires_a_space_to_be_valid',
  #        password:  'testtest'
  #      }
  #      url = "/api/v1/persons/#{ existing_person.slug }"
  #      put url, { person: params }, https_and_authorization
  #      response.code.should == '400'
  #      response.body.should == { error: 'Failed to update person' }.to_json
  #    end
  #  end
  #end

  #def valid_params
  #  {
  #    full_name: "#{ valid_first_name } #{ valid_last_name }",
  #    email:     'test@test.no',
  #    password:  'testtest'
  #  }
  #end

  #def valid_first_name; 'Firstname'; end
  #def valid_last_name;  'Lastname';  end
end
