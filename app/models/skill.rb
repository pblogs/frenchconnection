# == Schema Information
#
# Table name: skills
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Skill < ActiveRecord::Base
  has_and_belongs_to_many :tasks
  has_and_belongs_to_many :users
  validates :title, uniqueness: true
end
