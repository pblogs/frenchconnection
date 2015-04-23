# == Schema Information
#
# Table name: dynamic_forms
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  rows       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#

class DynamicForm < ActiveRecord::Base
  belongs_to :users
end
