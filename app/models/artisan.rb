class Artisan < ActiveRecord::Base
  has_and_belongs_to_many :tasks
  has_many :projects, :through => :tasks
end
