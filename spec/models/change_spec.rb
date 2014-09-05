require 'spec_helper'

describe Change do
  before :each do
    @hours_spent = Fabricate(:hours_spent, hour: 10 )
    @change  = Fabricate(:change, hours_spent: @hours_spent)
  end

  it "is valid from the Fabric" do
    expect(@change).to be_valid
  end

  describe 'is used to track changes of users hours' do
    it 'belongs to an hours_spent' do
      @change.hours_spent.should be @hours_spent
    end
    
  end
end
