class Project < ActiveRecord::Base
  belongs_to :customer
  has_many :tasks

  validates :customer_id, :presence => true
  validates :name,        :presence => true
end
