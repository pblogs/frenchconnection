# == Schema Information
#
# Table name: customers
#
#  id             :integer          not null, primary key
#  name           :string
#  address        :string
#  org_number     :string
#  contact_person :string
#  phone          :string
#  created_at     :datetime
#  updated_at     :datetime
#  customer_nr    :integer
#  area           :string
#  email          :string
#

class Customer < ActiveRecord::Base
  include Favorable

  validates :name, presence: true

  has_many :tasks, dependent: :destroy
  has_many :projects, dependent: :destroy
  has_many :favorites, as: :favorable

  class << self
    def last_updated_at
      Customer.order(:updated_at).select(:id, :updated_at).last.try(:updated_at)
    end
  end

end
