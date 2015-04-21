# == Schema Information
#
# Table name: api_keys
#
#  id           :integer          not null, primary key
#  name         :string
#  access_token :string
#  active       :boolean
#

Fabricator(:api_key) do
  name    {"description of site or app that uses it"}
  active  {true}
end
