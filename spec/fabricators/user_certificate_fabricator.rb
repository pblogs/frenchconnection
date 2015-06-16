# == Schema Information
#
# Table name: user_certificates
#
#  id             :integer          not null, primary key
#  certificate_id :integer
#  user_id        :integer
#  image          :string
#  expiry_date    :date
#

Fabricator(:user_certificate) do
  certificate_id 1
  user_id        1
  expiry_date DateTime.now
end
