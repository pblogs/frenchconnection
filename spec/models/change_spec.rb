require 'spec_helper'

describe Change do
  before :each do
    @hours_spent = Fabricate(:hours_spent, hour: 10, overtime_50: 500 )
    @change  = Fabricate(:change, hours_spent: @hours_spent)
  end

  it "is valid from the Fabric" do
    expect(@change).to be_valid
  end

  describe 'is used to track changes of users hours' do
    it 'belongs to an hours_spent' do
      @change.hours_spent.should be @hours_spent
    end

    it 'create_from_hours_spent' do
      reason =  'I know he was sick that day'
      @change = Change.create_from_hours_spent(hours_spent: @hours_spent, 
                         reason: reason )

      @change.hour.should eq @hours_spent.hour
      @change.hours_spent_id.should eq @hours_spent.id
      @change.overtime_50.should  eq @hours_spent.overtime_50
      @change.overtime_100.should eq @hours_spent.overtime_100
      @change.description.should  eq description
    end
  end

  describe 'changed values' do
    it 'returnes the changed values' do
      reason =  'I know he was sick that day'
      @change = Change.create_from_hours_spent(hours_spent: @hours_spent, 
                         reason: reason )

      @change.hour         = 1
      @change.overtime_50  = 5
      @change.save!
      @change.reload
      @change.overtime_50.should eq 5
      @hours_spent.reload
      @hours_spent.changed_value_overtime_50.should eq 5
      
    end
    
  end
end
