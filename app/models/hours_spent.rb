class HoursSpent < ActiveRecord::Base
  belongs_to :customer
  belongs_to :task

  validates :task,        :presence => true
  validates :hour,        :presence => true
  validates :description, :presence => true
  validates :date,        :presence => true
end
