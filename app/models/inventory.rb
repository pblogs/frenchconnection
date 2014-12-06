class Inventory < ActiveRecord::Base
  has_and_belongs_to_many :certificates
  validates :name, uniqueness: true
  validates :name, presence: true
  has_and_belongs_to_many :tasks
end
