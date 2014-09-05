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

    it 'create_from_hours_spent' do
      description =  'I know he was sick that day'
      @change = Change.create_from_hours_spent(hours_spent: @hours_spent, 
                         description: description )

      @change.hour.should eq @hours_spent.hour
      @change.hours_spent_id.should eq @hours_spent.id
      @change.overtime_50.should  eq @hours_spent.overtime_50
      @change.overtime_100.should eq @hours_spent.overtime_100
      @change.description.should  eq description
      
    end
    
  end
end
