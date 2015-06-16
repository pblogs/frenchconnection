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

require 'spec_helper'

describe MonthlyReport do
  pending "add some examples to (or delete) #{__FILE__}"
end
