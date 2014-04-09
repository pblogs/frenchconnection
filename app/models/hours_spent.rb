class HoursSpent < ActiveRecord::Base
  belongs_to :customer
  belongs_to :task

  validates :task,     :presence => true
end
