class Project < ActiveRecord::Base
  belongs_to :customer
  has_many :tasks
  has_many :hours_spents, :through => :tasks
  has_many :artisans,     :through => :tasks

  validates :customer_id, :presence => true
  validates :start_date,  :presence => true
  validates :due_date,    :presence => true
  validates :description, :presence => true

  def hours_spent_total
    sum = 0
    tasks.each { |t| sum += t.hours_spents.sum(:hour) }
    sum
  end

  def hours_total_for(artisan)
    hours_spents.where(artisan_id: artisan.id).sum(:hour) rescue nil
  end

  def name_of_artisans
    artisans.pluck(:name).join(', ' )
  end


end
