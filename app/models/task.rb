class Task < ActiveRecord::Base
  belongs_to :customer
  belongs_to :task_type
  belongs_to :paint
  belongs_to :artisan
  belongs_to :project

  has_many :hours_spents

  validates :customer, :presence => true
  validates :task_type, :presence => true
  validates :artisan,   :presence => true
  validates :start_date, :presence => true

  def hours_total
    self.hours_spents.sum(:hour)
  end

  
end
