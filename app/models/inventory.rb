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
