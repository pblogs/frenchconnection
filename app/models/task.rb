class Task < ActiveRecord::Base
  belongs_to :customer
  belongs_to :task_type
  belongs_to :paint

  validates :customer, :presence => true
  validates :task_type, :presence => true
end
