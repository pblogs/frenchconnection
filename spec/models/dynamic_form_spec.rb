# == Schema Information
#
# Table name: dynamic_forms
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  form_info  :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe DynamicForm, type: :model do

  before do
    @customer = Fabricate(:customer)

    @f = DynamicForm.create(
      field_name:          'Kundenavn',
      populate_at:         :web,
      autocomplete_from:   :customer_names
    )
  end

  it 'has a dynamic structure' do
    puts "its #{@f.inspect}"

  end
end
