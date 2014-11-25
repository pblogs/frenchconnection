require 'spec_helper'

describe Favorite do
  before :each do
    @favorite = Fabricate(:favorite)
  end

  it 'is valid from the fabric' do
    expect(@favorite).to be_valid
  end

end
