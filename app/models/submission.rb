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

class Submission < ActiveRecord::Base
  belongs_to :dynamic_form
  belongs_to :user

  validates :values,          presence: true
  validates :dynamic_form_id, presence: true
  validates :user_id,         presence: true
end
