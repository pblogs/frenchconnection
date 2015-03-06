# == Schema Information
#
# Table name: certificates
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Certificate < ActiveRecord::Base
  has_and_belongs_to_many :inventories
  has_many :user_certificates
  has_many :users, through: :user_certificates

  validates :title, uniqueness: true
end
