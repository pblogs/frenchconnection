# == Schema Information
#
# Table name: monthly_reports
#
#  id         :integer          not null, primary key
#  document   :string
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#  month_nr   :integer
#  title      :string
#  year       :integer
#

class MonthlyReport < ActiveRecord::Base
  validates :user_id,  presence: true
  validates :document, presence: true, unless: Proc.new { Rails.env.test? }

  belongs_to :user
  mount_uploader :document, DocumentUploader
end
