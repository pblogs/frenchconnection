# == Schema Information
#
# Table name: languages
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Language < ActiveRecord::Base
  has_many :user_languages
  has_many :languages, :through => :user_languages, :dependent => :destroy
end
