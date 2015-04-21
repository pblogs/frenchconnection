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

Fabricator(:favorite) do
  favorable { Fabricate(:project) }
  user { Fabricate(:user) }
end
