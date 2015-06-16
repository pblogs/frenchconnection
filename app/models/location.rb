# == Schema Information
#
# Table name: locations
#
#  id              :integer          not null, primary key
#  name            :string
#  certificates_id :integer
#  outdoor         :boolean
#  indoor          :boolean
#  created_at      :datetime
#  updated_at      :datetime
#

class Location < ActiveRecord::Base
  has_and_belongs_to_many :certificates
  validates :name, uniqueness: true
  validates :name, presence: true
end
