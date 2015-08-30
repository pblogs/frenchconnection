# == Schema Information
#
# Table name: user_languages
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  language_id :integer
#  rating      :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class UserLanguage < ActiveRecord::Base
  belongs_to :language
  belongs_to :user

  delegate :name, to: :language

  validates :rating, presence: true
  validates :user, presence: true
  validates :language, presence: true
end
