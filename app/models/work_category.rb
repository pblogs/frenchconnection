class WorkCategory < ActiveRecord::Base
  has_many :tasks
  validates :title, uniqueness: true
end
