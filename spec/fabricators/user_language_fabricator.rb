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

Fabricator(:user_language) do
  rating 1
  user { Fabricate(:user) }
  language { Fabricate(:language) }
end
