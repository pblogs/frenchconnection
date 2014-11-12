# == Schema Information
#
# Table name: departments
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Department < ActiveRecord::Base
  has_many :users
  has_many :projects
  has_many :customers, :through => :projects

  validates :title, :uniqueness => true
end
