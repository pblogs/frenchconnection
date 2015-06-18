# == Schema Information
#
# Table name: certificates
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

Fabricator(:certificate) do
  title "Driving Licence #{Fabricate.sequence}"
end
