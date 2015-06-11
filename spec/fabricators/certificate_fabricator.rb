# == Schema Information
#
# Table name: certificates
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime
#  updated_at :datetime
#

Fabricator(:certificate) do
  title "Driving Licence #{Fabricate.sequence}"
end
