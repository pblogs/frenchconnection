class Task < ActiveRecord::Base
  belongs_to :project
  belongs_to :task_type
  belongs_to :paint
  has_and_belongs_to_many :artisans

  has_many :hours_spents

  validates :project, :presence => true
  validates :task_type, :presence => true
  validates :start_date, :presence => true

  def hours_total
    self.hours_spents.sum(:hour)
  end

  def name_of_artisans
    artisans.pluck(:name).join(', ' )
  end
  
end
