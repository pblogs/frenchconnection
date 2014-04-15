class Project < ActiveRecord::Base
  belongs_to :customer
  has_many :tasks

  validates :customer_id, :presence => true
  validates :name,        :presence => true
  def hours_spent_total
    sum = 0
    tasks.each { |t| sum += t.hours_spents.sum(:hour) }
    sum
  end
end
