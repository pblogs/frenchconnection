class Certificate < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :inventories
  validates :title, uniqueness: true
end
