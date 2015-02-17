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

require 'spec_helper'

describe MonthlyReport do
  pending "add some examples to (or delete) #{__FILE__}"
end
