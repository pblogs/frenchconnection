# == Schema Information
#
# Table name: favorites
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  favorable_id   :integer
#  favorable_type :string
#  created_at     :datetime
#  updated_at     :datetime
#

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
