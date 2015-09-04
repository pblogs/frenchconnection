# == Schema Information
#
# Table name: settings
#
#  id                             :integer          not null, primary key
#  automatic_project_numbers      :boolean          default(TRUE)
#  manual_project_numbers         :boolean          default(FALSE)
#  enable_project_reference_field :boolean          default(FALSE)
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#

class Setting < ActiveRecord::Base
end
