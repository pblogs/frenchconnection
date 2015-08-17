class UserLanguage < ActiveRecord::Base
  belongs_to :language
  belongs_to :user

  delegate :name, to: :language

  validates :rating, presence: true
  validates :user, presence: true
  validates :language, presence: true
end
