# == Schema Information
#
# Table name: mobile_pictures
#
#  id          :integer          not null, primary key
#  task_id     :integer
#  user_id     :integer
#  url         :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  project_id  :integer
#

Fabricator(:mobile_picture) do
  task        { Fabricate(:task) }
  user        { Fabricate(:user) }
  url         "http://alliero.orwapp.com/assets/Alliero-header-cd52ac88e9edf6e748c7ef4245954826.gif"
  description "Alliero header"
  project     { Fabricate(:project) }
end
