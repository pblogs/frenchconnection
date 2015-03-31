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
