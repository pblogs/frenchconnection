# == Schema Information
#
# Table name: api_keys
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  access_token :string(255)
#  active       :boolean
#

Fabricator(:api_key) do
  name    {"description of site or app that uses it"}
  active  {true}
end
