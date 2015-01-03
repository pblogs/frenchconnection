# == Schema Information
#
# Table name: professions
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Profession < ActiveRecord::Base
  validates :title, :uniqueness => true
  has_many :skills
end
