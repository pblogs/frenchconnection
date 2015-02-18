require 'spec_helper'

describe V1::HoursSpent do

  # updates existing HoursSpent
  describe 'PUT /api/v1/hours_spents/:hours_spent_id' do
    it 'creates HoursSpent for user on task on date and returns its id' do
      hours_spent = Fabricate(:hours_spent, hour: 4, description: 'Matle ush')
      
      expect {
        put "/api/v1/hours_spents/#{ hours_spent.id }", 
            { hour: 5, description: 'Malte hus' }
      }.to change{ HoursSpent.all.size}.by(0)
      
      hours_spent = HoursSpent.find(hours_spent.id)
      hours_spent.hour.should eq 5
      hours_spent.description.should eq 'Malte hus'
      
    end
  end
  
  # creates HoursSpent for user on task on date
  describe 'POST /api/v1/hours_spents/users/:user_id/tasks/:task_id/dates/:date' do
    before do
      @date = Date.parse '2014-01-01'
      @task = Fabricate(:task)
      @user = Fabricate(:user)
    end

    it 'creates HoursSpent for user on task on date and returns its id' do
      expect {
        post "/api/v1/hours_spents/users/#{ @user.id }/" +
             "tasks/#{ @task.id }/dates/#{ @date }", 
             { description: 'Malte hus', hour: 5 }
      }.to change{ @user.hours_spents.all.size}.from(0).to(2)
           
      hours_spent_id = response.body
      hours_spent    = HoursSpent.find(hours_spent_id)
      
      hours_spent.hour.should eq 5
      hours_spent.description.should eq 'Malte hus'
      @user.hours_spents.personal.first.description.should eq 'Malte hus'
      hours_spent.user.should eq @user
      hours_spent.task.should eq @task
      hours_spent['date'].should eq @date
      
    end
  end
  
  describe 'GET /api/v1/hours_spents/users/:user_id/tasks/:task_id/dates/:date' do
    it 'returns HoursSpent for user on task on date' do
      date = Date.parse '2014-01-01'
      task = Fabricate(:task)
      user = Fabricate(:user)
      hours_spent = Fabricate(:hours_spent, user: user, 
                  task: task, date: date, hour: 5)
      
      hours_spent_same_task_date_different_user = Fabricate(:hours_spent, 
        user: Fabricate(:user), task: task, date: date, hour: 6)

      hours_spent_same_task_user_different_date = Fabricate(:hours_spent, 
        user: user, task: task, date: date + 1, hour: 7)

      hours_spent_same_date_user_different_task = Fabricate(:hours_spent,
        user: user, task: Fabricate(:task), date: date, hour: 8)
      
      get "/api/v1/hours_spents/users/#{ user.id }" +
          "/tasks/#{ task.id }/dates/#{ date }"
      hash = JSON.parse(response.body)
      
      hash['hours_spents'].length.should eq 1
      hash['hours_spents'].first['hour'].should eq 5
    end
  end

end
