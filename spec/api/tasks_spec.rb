require 'spec_helper'

describe V1::Tasks do
   
  describe 'POST /api/v1/tasks/:task_id/users/:user_id/confirm_user_task' do
    it 'confirms user_task' do
      user = Fabricate(:user)
      task = Fabricate(:task)
      user.tasks << task
      user.save

      post "/api/v1/tasks/#{ task.id }/users/#{ user.id }/confirm_user_task"
      user.user_tasks.where(task_id: task.id).first.status.should eq :confirmed
    end
  end
  
  describe 'POST /api/v1/tasks/:task_id/users/:user_id/complete_user_task' do
    it 'marks user_task as complete' do
      user = Fabricate(:user)
      task = Fabricate(:task)
      user.tasks << task
      user.save

      post "/api/v1/tasks/#{ task.id }/users/#{ user.id }/complete_user_task"
      user.user_tasks.where(task_id: task.id).first.status.should eq :complete
    end
  end
  
  describe 'GET /api/v1/tasks/unconfirmed/:user_id' do
    it 'returns Tasks' do
      user = Fabricate(:user)
      task1 = Fabricate(:task, description: 'Task 1')
      task2 = Fabricate(:task, description: 'Task 2')
      user.tasks << task1
      user.tasks << task2
      user.save
      
      user.user_tasks.where(task_id: task1.id).first.confirm!
      
      get "/api/v1/tasks/unconfirmed/#{ user.id }"
      
      hash = JSON.parse(response.body)
      hash['tasks'].first['description'].should eq 'Task 2'
    end
  end
  
  describe 'GET /api/v1/tasks/confirmed/:user_id' do
    it 'returns Tasks' do
      user = Fabricate(:user)
      task1 = Fabricate(:task, description: 'Task 1')
      task2 = Fabricate(:task, description: 'Task 2')
      user.tasks << task1
      user.tasks << task2
      user.save
      
      user.user_tasks.where(task_id: task1.id).first.confirm!
      
      get "/api/v1/tasks/confirmed/#{ user.id }"
      
      hash = JSON.parse(response.body)
      hash['tasks'].first['description'].should eq 'Task 1'
    end
  end
  
  describe 'GET /api/v1/tasks/complete/:user_id' do
    it 'returns complete tasks that are not finished' do
      user = Fabricate(:user)
      task1 = Fabricate(:task, description: 'Task 1')
      task2 = Fabricate(:task, description: 'Task 2')
      user.tasks << task1
      user.tasks << task2
      user.save
      
      user.user_tasks.where(task_id: task1.id).first.complete!
      user.user_tasks.where(task_id: task2.id).first.complete!
      
      task2.update_attributes(finished: true)
      
      get "/api/v1/tasks/complete/#{ user.id }"
      
      hash = JSON.parse(response.body)
      hash['tasks'].first['description'].should eq 'Task 1'
    end
  end
  
  describe 'GET /api/v1/tasks/available/:user_id' do
    it 'returns Tasks not connected to user' do
      Task.destroy_all
      user = Fabricate(:user)
      task1 = Fabricate(:task, description: 'Task 1')
      task2 = Fabricate(:task, description: 'Task 2')
      task3 = Fabricate(:task, description: 'Task 3')
      user.tasks << task1
      user.save
      get "/api/v1/tasks/available/#{ user.id }"
      hash = JSON.parse(response.body)
      #puts "ARRAY: #{hash}"
      hash['tasks'].length.should eq 2
      task_descriptions = hash['tasks'].collect { |task| task['description'] }
      # same elements, order unimportant
      task_descriptions.should =~ ['Task 3', 'Task 2'] 
    end
  end
  
end
