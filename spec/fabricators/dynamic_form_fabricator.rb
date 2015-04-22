# == Schema Information
#
# Table name: dynamic_forms
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  rows       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#

Fabricator(:dynamic_form) do
  field_name        "MyString"
  populate          "MyString"
  autocomplete_from "MyString"
  title             "MyString"
end
