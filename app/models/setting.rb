# == Schema Information
#
# Table name: settings
#
#  id                             :integer          not null, primary key
#  project_numbers                :string           default("automatic")
#  enable_project_reference_field :string           default("f")
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#

class Setting < ActiveRecord::Base
end
