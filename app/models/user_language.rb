class UserLanguage < ActiveRecord::Base
  belongs_to :language
  belongs_to :user

  delegate :name, to: :language
end
