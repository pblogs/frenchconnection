class HoursSpent < ActiveRecord::Base
  belongs_to :user
  belongs_to :task
  belongs_to :project

  validates :task,        :presence => true
  validates :user,        :presence => true
  validates :description, :presence => true
  validates :date,        :presence => true

  def sum
    @hour            rescue 0 +
    @piecework_hours rescue 0 +
    @overtime_50     rescue 0 +
    @overtime_100    rescue 0  
  end
end
