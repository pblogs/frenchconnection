# == Schema Information
#
# Table name: task_types
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime
#  updated_at :datetime
#

Fabricator(:task_type) do
  title { %W( maling snekring pussing muring ).sample }
end

