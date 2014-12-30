require 'spec_helper'

describe V1::MobilePicture do
  
  # creates MobilePicture for user on task
  describe 'POST /api/v1/mobile_pictures/users/:user_id/tasks/:task_id' do
    it 'creates MobilePicture for user on task and returns its id' do
      task = Fabricate(:task)
      user = Fabricate(:user)
      
      post "/api/v1/mobile_pictures/users/#{ user.id }/tasks/#{ task.id }", 
           { url: 'http://picture_url', description: 'picture_description' }
           
      mobile_picture_id = response.body
      
      another_mobile_picture = Fabricate(:mobile_picture)
      
      mobile_picture = MobilePicture.find(mobile_picture_id)
      
      mobile_picture.url.should eq 'http://picture_url'
      mobile_picture.description.should eq 'picture_description'
      mobile_picture.user.should eq user
      mobile_picture.task.should eq task
    end
  end
  
  # gets array of MobilePictures for user on task
  describe 'GET /api/v1/mobile_pictures/users/:user_id/tasks/:task_id' do
    it 'returns MobilePictures for user on task' do
      task = Fabricate(:task)
      user = Fabricate(:user)
      mobile_picture = Fabricate(:mobile_picture, user: user, task: task)
      
      another_mobile_picture = Fabricate(:mobile_picture)
      
      get "/api/v1/mobile_pictures/users/#{ user.id }/tasks/#{ task.id }"
      
      hash = JSON.parse(response.body)
      
      hash['mobile_pictures'].length.should eq 1
      hash['mobile_pictures'].first['url'].should eq mobile_picture.url  
    end
  end

end
