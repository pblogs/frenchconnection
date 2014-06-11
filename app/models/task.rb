class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :task_type
  belongs_to :paint
  has_and_belongs_to_many :users

  has_many :hours_spents

  validates :project_id, :presence => true
  validates :task_type,  :presence => true
  validates :start_date, :presence => true
  validates :due_date,   :presence => true

  attr_accessor :department_id

  def hours_total
    self.hours_spents.sum(:hour)
  end

  def name_of_artisans
    users.pluck(:first_name).join(', ' )
  end
  
end
