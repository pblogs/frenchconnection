# == Schema Information
#
# Table name: monthly_reports
#
#  id         :integer          not null, primary key
#  report     :string(255)
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class MonthlyReport < ActiveRecord::Base
  validates :user_id,  presence: true
  validates :document, presence: true, unless: Proc.new { Rails.env.test? }

  belongs_to :user
  mount_uploader :document, DocumentUploader
end
