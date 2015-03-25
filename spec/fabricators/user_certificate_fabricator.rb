Fabricator(:user_certificate) do
  certificate_id 1
  user_id        1
  expiry_date DateTime.now
end
