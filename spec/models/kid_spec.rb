# == Schema Information
#
# Table name: kids
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  name         :string
#  birth_date   :date
#  sole_custody :boolean          default(FALSE)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Kid, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
