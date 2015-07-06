# == Schema Information
#
# Table name: mobile_pictures
#
#  id          :integer          not null, primary key
#  task_id     :integer
#  user_id     :integer
#  url         :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  project_id  :integer
#

require 'spec_helper'

describe MobilePicture do
  before :all do
    @task           = Fabricate(:task)
    @mobile_picture = Fabricate(:mobile_picture, task: @task)
  end

  it "is valid from the Fabric" do
    expect(@mobile_picture).to be_valid
  end

  it 'belongs to a task' do
    expect(@mobile_picture.task).to eq @task
  end

  it 'a task has many pictures' do
    @mobile_picture2 = Fabricate(:mobile_picture, task: @task)
    expect(@task.mobile_pictures.to_a).to include(@mobile_picture, @mobile_picture2)
  end
end
