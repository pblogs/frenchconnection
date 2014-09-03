class HoursSpent < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  belongs_to :project

  validates :task,        :presence => true
  validates :user,        :presence => true
  validates :description, :presence => true
  validates :date,        :presence => true
  validates :project_id,     :presence => true

  def sum
    (self.hour            ||  0) +
    (self.piecework_hours ||  0) +
    (self.overtime_50     ||  0) +
    (self.overtime_100    ||  0)  
  end
end
