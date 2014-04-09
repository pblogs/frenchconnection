class Customer < ActiveRecord::Base
  validates :name,           :presence => true          
  validates :address,        :presence => true
  validates :org_number,     :presence => true
  validates :contact_person, :presence => true
  validates :phone,          :presence => true

  has_many :tasks

end
