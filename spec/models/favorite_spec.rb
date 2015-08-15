# == Schema Information
#
# Table name: favorites
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  favorable_id   :integer
#  favorable_type :string
#  created_at     :datetime
#  updated_at     :datetime
#

require 'spec_helper'

describe Favorite do
  before :each do
    @favorite = Fabricate(:favorite)
  end

  it 'is valid from the fabric' do
    expect(@favorite).to be_valid
  end

end
