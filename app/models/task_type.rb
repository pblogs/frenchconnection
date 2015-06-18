# == Schema Information
#
# Table name: task_types
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class TaskType < ActiveRecord::Base
end
