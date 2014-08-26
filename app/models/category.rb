class Category < ActiveRecord::Base
  validates :name, :presence => true

  has_many :projects
  has_many :customers, :through => :projects

end
