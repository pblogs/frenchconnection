class HoursSpent < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  belongs_to :project

  validates :task,        :presence => true
  validates :user,     :presence => true
  validates :description, :presence => true
  validates :date,        :presence => true
end
