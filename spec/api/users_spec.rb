require 'spec_helper'

describe V1::Users do

  describe 'GET /api/v1/users/:id' do
    it 'lists a specific user' do
      user = Fabricate :user
      get "/api/v1/users/#{ user.id }"
      response.status.should == 200
      hash = JSON.parse(response.body)
      hash['email'].should eq user.email
    end
  end
   
  describe 'POST /api/v1/users/:id/tasks/:task_id/confirm_user_task' do
    it 'confirms user_task' do
      user = Fabricate(:user)
      task = Fabricate(:task)
      user.tasks << task
      user.save

      post "/api/v1/users/#{ user.id }/tasks/#{ task.id }/confirm_user_task"
      user.user_tasks.where(task_id: task.id).first.status.should eq :confirmed
    end
  end

  # WIP - returns all tasks today. 
  describe 'GET /api/v1/users/:id/confirmed_tasks' do
    it 'returns Tasks' do
      user = Fabricate(:user)
      task1 = Fabricate(:task, description: 'Task 1')
      task2 = Fabricate(:task, description: 'Task 2')
      user.tasks << task1
      user.tasks << task2
      user.save
      
      user.user_tasks.where(task_id: task1.id).first.confirm!
      
      get "/api/v1/users/#{ user.id }/confirmed_tasks"
      
      hash = JSON.parse(response.body)
      hash['tasks'].first['description'].should eq 'Task 1'
    end
  end

  # WIP - returns all tasks today. 
  describe 'GET /api/v1/users/:id/unconfirmed_tasks' do
    it 'returns Tasks' do
      user = Fabricate(:user)
      task1 = Fabricate(:task, description: 'Task 1')
      task2 = Fabricate(:task, description: 'Task 2')
      user.tasks << task1
      user.tasks << task2
      user.save
      
      user.user_tasks.where(task_id: task1.id).first.confirm!
      
      get "/api/v1/users/#{ user.id }/unconfirmed_tasks"
      
      hash = JSON.parse(response.body)
      hash['tasks'].first['description'].should eq 'Task 2'
    end
  end
  
  # returns all tasks not connected to user
  describe 'GET /api/v1/users/:id/available_tasks' do
    it 'returns Tasks not connected to user' do
      Task.destroy_all
      user = Fabricate(:user)
      task1 = Fabricate(:task, description: 'Task 1')
      task2 = Fabricate(:task, description: 'Task 2')
      task3 = Fabricate(:task, description: 'Task 3')
      user.tasks << task1
      user.save
      get "/api/v1/users/#{ user.id }/available_tasks"
      hash = JSON.parse(response.body)
      #puts "ARRAY: #{hash}"
      hash['tasks'].length.should eq 2
      task_descriptions = hash['tasks'].collect { |task| task['description'] }
      # same elements, order unimportant
      task_descriptions.should =~ ['Task 3', 'Task 2'] 
    end
  end
  
  # returns hours_spent for user on task on date
  describe 'GET /api/v1/users/:id/tasks/:task_id/hours_spents/:date' do
    it 'returns HoursSpent for user on task on date' do
      date = Date.parse '2014-01-01'
      task = Fabricate(:task)
      user = Fabricate(:user)
      hours_spent = 
        Fabricate(:hours_spent, user: user, 
                  task: task, date: date, hour: 5)
      
      hours_spent_same_task_date_different_user = 
        Fabricate(:hours_spent, user: Fabricate(:user), 
                  task: task, date: date, hour: 6)
      hours_spent_same_task_user_different_date = 
        Fabricate(:hours_spent, user: user, 
                  task: task, date: date + 1, hour: 7)
      hours_spent_same_date_user_different_task = 
        Fabricate(:hours_spent, user: user, 
                  task: Fabricate(:task), date: date, hour: 8)
      
      get "/api/v1/users/#{ user.id }" +
          "/tasks/#{ task.id }/hours_spents/#{ date }"
      hash = JSON.parse(response.body)
      #puts "ARRAY: #{hash}"
      
      hash['hours_spents'].length.should eq 1
      hash['hours_spents'].first['hour'].should eq 5
    end
  end
  
  # creates HoursSpent for user on task on date
  describe 'POST /api/v1/users/:id/tasks/:task_id/hours_spents/:date' do
    it 'creates HoursSpent for user on task on date and returns its id' do
      date = Date.parse '2014-01-01'
      task = Fabricate(:task)
      user = Fabricate(:user)
      
      post "/api/v1/users/#{ user.id }/" +
           "tasks/#{ task.id }/hours_spents/#{ date }", 
           { description: 'Malte hus', hour: 5 }
           
      hours_spent_id = response.body
      
      another_hours_spent = Fabricate(:hours_spent)
      
      hours_spent = HoursSpent.find(hours_spent_id)
      
      hours_spent.hour.should eq 5
      hours_spent.description.should eq 'Malte hus'
      hours_spent.user.should eq user
      hours_spent.task.should eq task
      hours_spent['date'].should eq date
      
    end
  end
  
  
  
  #describe 'GET /api/v1/users' do
  #  it 'returns array of users' do
  #    3.times { Fabricate :user }
  #    get '/api/v1/users', {}, https_and_authorization
  #    response.status.should eq 200
  #    expected_ids = User.all.page(1).map { |a| a.id.to_s }
  #    expected_ids.each { |id| response.body.should match id }
  #  end
  #end

  #describe 'GET /api/v1/me' do
  #  pending "Not implemented"
  #  let(:user)  { Fabricate :user }
  #  let(:token) { Fabricate :access_token, resource_owner_id: user.id }

  #  before { api_current_user_stubbing_setup(user) }
  #  after  { api_current_user_stubbing_teardown }
  #  before do
  #    @ad = Fabricate(:ad, user: user, title: 'New shoes')
  #    Fabricate(:ad, user: user, title: 'Fresh fish')
  #    Fabricate(:message, recipient: user,
  #              content: 'How much for the fish?',
  #              ad: @ad, sender: Fabricate(:user))
  #  end

  #  it 'returns the current_user, nr of unread messags and nr of users' do
  #    get "/api/v1/me", {}, https_and_authorization
  #    response.status.should eq 200
  #    parse_response_for(:me)['user']['email'].should   eq user.email
  #    parse_response_for(:me)['unread_msg_size'].should eq 1
  #    parse_response_for(:me)['users_size'].should        eq 2
  #  end

  #  it 'includes conversations' do
  #    get "/api/v1/me?include=conversations", {}, https_and_authorization
  #    response.status.should eq 200
  #    parse_response_for(:me)['user']['email'].should   eq user.email
  #    parse_response_for(:me)['unread_msg_size'].should eq 1
  #    parse_response_for(:me)['users_size'].should        eq 2
  #    parse_response_for(:me)['conversations']
  #      .first['message']['content'].should eq 'How much for the fish?'
  #    parse_response_for(:me)['users'].should be_nil
  #  end

  #  #it 'includes users' do
  #  #  get "/api/v1/me?include=users", {}, https_and_authorization
  #  #  response.status.should eq 200
  #  #  parse_response_for(:me)['user']['email'].should   eq user.email
  #  #  parse_response_for(:me)['unread_msg_size'].should eq 1
  #  #  parse_response_for(:me)['users_size'].should        eq 2
  #  #  parse_response_for(:me)['users']
  #  #    .first['title'].should eq 'Fresh fish'
  #  #  parse_response_for(:me)['conversations'].should be_nil
  #  #end

  #  #it 'includes users and conversations' do
  #  #  get "/api/v1/me?include=all", {}, https_and_authorization
  #  #  response.status.should eq 200
  #  #  parse_response_for(:me)['user']['email'].should   eq user.email
  #  #  parse_response_for(:me)['unread_msg_size'].should eq 1
  #  #  parse_response_for(:me)['users_size'].should        eq 2
  #  #  parse_response_for(:me)['users']
  #  #    .first['title'].should eq 'Fresh fish'
  #  #  parse_response_for(:me)['conversations']
  #  #    .first['message']['content'].should eq 'How much for the fish?'
  #  #end
  #end


  #describe 'GET /api/v1/users/:id', focus: true do
  #  let(:user) { Fabricate :user }
  #describe 'GET /api/v1/users/:id', focus: true do
  #  let(:user) { Fabricate :user }

  #  it 'returns that specific user' do
  #    get "/api/v1/users/#{ user.id }", {}, https_and_authorization
  #    response.status.should eq 200
  #    parse_response_for(:user)['email'].should eq user.email
  #  end
  #end

  #describe 'GET /api/v1/users/:id/users' do
  #  let(:user) { Fabricate :user }

  #  it 'returns that specific user' do
  #    url = "/api/v1/users/#{ user.slug }/users"
  #    get url, {}, https_and_authorization
  #    response.code.should eq '200'
  #    parse_response_for(:user)['email'].should eq user.email
  #  end

  #  it 'returns array of that users users' do
  #    user_ad = Fabricate :ad, user: user
  #    url = "/api/v1/users/#{ user.slug }/users"
  #    get url, {}, https_and_authorization
  #    response.code.should eq '200'
  #    parse_response_for(:user)['users'].first['id'].should eq user_ad.id.to_s
  #  end
  #end

  #describe 'POST /api/v1/users' do
  #  context 'with valid params' do
  #    it 'returns the newly created user' do
  #      post '/api/v1/users', valid_params, https_and_authorization
  #      response.code.should eq '201'
  #      parse_response_for(:user)['email'].should eq valid_params[:email]
  #    end
  #  end

  #  context 'with invalid params' do
  #    it 'returns validation message' do
  #      params = { full_name: 'Ola Nordmann', password: 'testtest' }
  #      post '/api/v1/users', params, https_and_authorization
  #      response.code.should eq '400'
  #      parse_response_for(:error).should eq 'email is missing'
  #    end
  #  end
  #end

  #describe 'PUT /api/v1/users/:id' do
  #  let(:existing_user) { Fabricate(:user) }

  #  context 'with valid params' do
  #    it 'returns the newly updated user' do
  #      url = "/api/v1/users/#{ existing_user.slug }"
  #      put url, valid_params, https_and_authorization
  #      response.code.should eq '200'
  #      parsed_response = parse_response_for(:user)
  #      parsed_response['first_name'].should eq valid_first_name
  #      parsed_response['last_name'].should  eq valid_last_name
  #    end
  #  end

  #  context 'with invalid params' do
  #    it 'returns error message' do
  #      params = {
  #        full_name: 'requires_a_space_to_be_valid',
  #        password:  'testtest'
  #      }
  #      url = "/api/v1/users/#{ existing_user.slug }"
  #      put url, params, https_and_authorization
  #      response.code.should eq '400'
  #      parse_response_for(:error).should have_key 'first_name'
  #    end
  #  end
  #end

  #describe 'POST /api/v1/users/reset_password' do
  #  context 'with invalid params' do
  #    it 'returns error message' do
  #      post '/api/v1/users/reset_password', {}, https_and_authorization
  #      response.code.should eq '400'
  #      parse_response_for(:error).should eq 'email is missing'
  #    end
  #  end

  #  context 'given existing user' do
  #    let(:user) { Fabricate :user }

  #    it 'returns the user' do
  #      params = { email: user.email }
  #      post '/api/v1/users/reset_password', params, https_and_authorization
  #      response.code.should eq '201'
  #      parse_response_for(:user)['first_name'].should eq user.first_name
  #    end
  #  end

  #  context 'when user not in database' do
  #    it 'returns error message' do
  #      params = { email: 'unknown@test.no' }
  #      post '/api/v1/users/reset_password', params, https_and_authorization
  #      response.code.should eq '400'
  #      expected_error = I18n.t('errors.messages.not_found')
  #      parse_response_for(:error)['email'].should include expected_error
  #    end
  #  end
  #end


  #describe 'POST /api/v1/users/resend_activation' do
  #  context 'with invalid params' do
  #    it 'returns error message' do
  #      post '/api/v1/users/resend_activation', {}, https_and_authorization
  #      response.code.should eq '400'
  #      parse_response_for(:error).should eq 'email is missing'
  #    end
  #  end

  #  context 'given unconfirmed user' do
  #    let(:user) { Fabricate :unconfirmed_user }

  #    it 'returns the user' do
  #      params = { email: user.email }
  #      post '/api/v1/users/resend_activation', params, https_and_authorization
  #      response.code.should eq '201'
  #      parse_response_for(:user)['first_name'].should eq user.first_name
  #    end
  #  end

  #  context 'given already confirmed user' do
  #    let(:user) { Fabricate :user }

  #    it 'returns error message' do
  #      params = { email: user.email }
  #      post '/api/v1/users/resend_activation', params, https_and_authorization
  #      response.code.should eq '400'
  #      expected_error = I18n.t('errors.messages.already_confirmed')
  #      parse_response_for(:error)['email'].should include expected_error
  #    end
  #  end

  #  context 'when user not in database' do
  #    it 'returns error message' do
  #      params = { email: 'unknown@test.no' }
  #      post '/api/v1/users/resend_activation', params, https_and_authorization
  #      response.code.should eq '400'
  #      expected_error = I18n.t('errors.messages.not_found')
  #      parse_response_for(:error)['email'].should include expected_error
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
