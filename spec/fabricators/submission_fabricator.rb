# == Schema Information
#
# Table name: submissions
#
#  id              :integer          not null, primary key
#  data            :json
#  dynamic_form_id :integer
#  user_id         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

Fabricator(:submission) do
  data         ""
  dynamic_form nil
  user         nil
end
