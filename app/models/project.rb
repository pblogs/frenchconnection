class Project < ActiveRecord::Base
  belongs_to :customer
  has_many :tasks
  has_many :hours_spents, :through => :tasks
  has_many :artisans,     :through => :tasks

  validates :customer_id, :presence => true
  validates :name,        :presence => true
  validates :start_date,  :presence => true

  def hours_spent_total
    sum = 0
    tasks.each { |t| sum += t.hours_spents.sum(:hour) }
    sum
  end

  def name_of_artisans
    artisans.pluck(:name).join(', ' )
  end

end
