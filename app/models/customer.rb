# == Schema Information
#
# Table name: customers
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  address        :string(255)
#  org_number     :string(255)
#  contact_person :string(255)
#  phone          :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#  customer_nr    :integer
#  area           :string(255)
#  email          :string(255)
#  starred        :boolean
#

class Customer < ActiveRecord::Base
  validates :name, presence: true
  validates :customer_nr, uniqueness: true

  has_many :tasks, dependent: :destroy
  has_many :projects, dependent: :destroy

end
