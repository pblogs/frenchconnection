class HoursSpent < ActiveRecord::Base
  belongs_to :artisan
  belongs_to :task

  validates :task,        :presence => true
  validates :artisan,     :presence => true
  validates :hour,        :presence => true
  validates :description, :presence => true
  validates :date,        :presence => true
end
