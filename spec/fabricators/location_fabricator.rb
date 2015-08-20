# == Schema Information
#
# Table name: locations
#
#  id              :integer          not null, primary key
#  name            :string
#  certificates_id :integer
#  outdoor         :boolean
#  indoor          :boolean
#  created_at      :datetime
#  updated_at      :datetime
#

Fabricator(:location) do
  name      "MyString"
end
