class Task < ActiveRecord::Base
  belongs_to :customer
  belongs_to :task_type
  belongs_to :paint
  belongs_to :artisan

  validates :customer, :presence => true
  validates :task_type, :presence => true
end
