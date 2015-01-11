class Skill < ActiveRecord::Base
  has_and_belongs_to_many :tasks
  validates :title, uniqueness: true
end
