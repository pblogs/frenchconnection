# == Schema Information
#
# Table name: skills
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime
#  updated_at :datetime
#

class Skill < ActiveRecord::Base
  has_and_belongs_to_many :tasks
  has_and_belongs_to_many :users
  validates :title, uniqueness: true
  validates :title, presence: true
end
