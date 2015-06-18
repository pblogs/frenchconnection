# == Schema Information
#
# Table name: inventories
#
#  id                               :integer          not null, primary key
#  name                             :string(255)
#  description                      :string(255)
#  certificates_id                  :integer
#  can_be_rented_by_other_companies :boolean          default(FALSE)
#  rental_price_pr_day              :integer
#  created_at                       :datetime
#  updated_at                       :datetime
#

class Inventory < ActiveRecord::Base
  has_and_belongs_to_many :certificates
  validates :name, uniqueness: true
  validates :name, presence: true
  has_and_belongs_to_many :tasks

  class << self
    def last_updated_at
      Inventory.order(:updated_at).select(:id, :updated_at).last.try(:updated_at)
    end
  end

end
