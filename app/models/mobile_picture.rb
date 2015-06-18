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

class MobilePicture < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  belongs_to :project
  
  validates :task,        :presence => true
  validates :user,        :presence => true
  validates :project,     :presence => true
  validates :url,         :presence => true
end
