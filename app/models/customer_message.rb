# == Schema Information
#
# Table name: customer_messages
#
#  id         :integer          not null, primary key
#  text       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class CustomerMessage < ActiveRecord::Base
end
