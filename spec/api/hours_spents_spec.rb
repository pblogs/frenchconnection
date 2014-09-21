require 'spec_helper'

describe V1::HoursSpent do

  # updates existing HoursSpent
  describe 'PUT /api/v1/hours_spents/:hours_spent_id' do
    it 'creates HoursSpent for user on task on date and returns its id' do
      hours_spent = Fabricate(:hours_spent, hour: 4, description: 'Matle ush')
      
      put "/api/v1/hours_spents/#{ hours_spent.id }", 
          { hour: 5, description: 'Malte hus' }
      
      hours_spent = HoursSpent.find(hours_spent.id)
      hours_spent.hour.should eq 5
      hours_spent.description.should eq 'Malte hus'
      
    end
  end

end
