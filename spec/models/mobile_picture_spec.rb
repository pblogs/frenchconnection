# == Schema Information
#
# Table name: mobile_pictures
#
#  id          :integer          not null, primary key
#  task_id     :integer
#  user_id     :integer
#  url         :string(255)
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  project_id  :integer
#

require 'spec_helper'

describe MobilePicture do
  pending "add some examples to (or delete) #{__FILE__}"
end
