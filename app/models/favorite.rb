class Favorite < ActiveRecord::Base

  scope :projects, -> { where(favorable_type: 'Project') }
  scope :customers, -> { where(favorable_type: 'Customer') }

  belongs_to :user
  belongs_to :favorable, polymorphic: true

  validates :favorable_id, uniqueness: { scope: [ :favorable_type,
                                                  :user_id ] }, presence: true
  validates :favorable_type, presence: true
  validates :user_id, presence: true
end
