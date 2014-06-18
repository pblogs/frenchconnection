require 'spec_helper'

describe V1::Users do
  describe 'GET /api/v1/users' do
    it 'returns array of users' do
      get '/api/v1/users', {}, https_and_authorization
      response.status.should == 200
      parse_response_for(:users).should == User.all
    end
  end

  #describe 'GET /api/v1/users/:id' do
  #  let(:user) { Fabricate :user }

  #  it 'returns that specific user' do
  #    get "/api/v1/users/#{ user.slug }", {}, https_and_authorization
  #    response.status.should == 200
  #    parse_response_for(:user)['email'].should == user.email
  #  end
  #end

  #describe 'GET /api/v1/users/:id/ads' do
  #  let(:user) { Fabricate :user }

  #  it 'returns that specific user' do
  #    url = "/api/v1/users/#{ user.slug }/ads"
  #    get url, {}, https_and_authorization
  #    response.code.should == '200'
  #    parse_response_for(:user)['email'].should == user.email
  #  end

  #  it 'returns array of that users ads' do
  #    user_ad = Fabricate :ad, user: user
  #    url = "/api/v1/users/#{ user.slug }/ads"
  #    get url, {}, https_and_authorization
  #    response.code.should == '200'
  #    parse_response_for(:user)['ads'].first['id'].should == user_ad.id.to_s
  #  end
  #end

  #describe 'POST /api/v1/users' do
  #  context 'with valid params' do
  #    it 'returns the newly created user' do
  #      post '/api/v1/users', { user: valid_params }, https_and_authorization
  #      response.code.should == '201'
  #      parse_response_for(:user)['email'].should == valid_params[:email]
  #    end
  #  end

  #  context 'with invalid params' do
  #    it 'returns validation message' do
  #      params = { full_name: 'Ola Nordmann', password: 'testtest' }
  #      post '/api/v1/users', { user: params }, https_and_authorization
  #      response.code.should == '400'
  #      parse_response_for(:error).should == 'user[email] is missing'
  #    end
  #  end
  #end

  #describe 'PUT /api/v1/users/:id' do
  #  let(:existing_user) { Fabricate(:user) }

  #  context 'with valid params' do
  #    it 'returns the newly updated user' do
  #      url = "/api/v1/users/#{ existing_user.slug }"
  #      put url, { user: valid_params }, https_and_authorization
  #      response.code.should == '200'
  #      parsed_response = parse_response_for(:user)
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
  #      url = "/api/v1/users/#{ existing_user.slug }"
  #      put url, { user: params }, https_and_authorization
  #      response.code.should == '400'
  #      response.body.should == { error: 'Failed to update user' }.to_json
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
