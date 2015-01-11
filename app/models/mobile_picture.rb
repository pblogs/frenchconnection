class MobilePicture < ActiveRecord::Base
  belongs_to :task
  belongs_to :user
  belongs_to :project
  
  validates :task,        :presence => true
  validates :user,        :presence => true
  validates :project,     :presence => true
  validates :url,         :presence => true
end
