require 'spec_helper'

describe "Registered hours on a Task" do
  before :each do
    @artisan = Fabricate(:artisan, name: 'Josh')
    Fabricate(:paint, title: 'Acryl')
    Fabricate(:paint, title: 'Beis')
    Fabricate(:task_type, title: 'Muring')
    Fabricate(:task_type, title: 'Maling')
    Fabricate(:customer, name: 'Oslo Sporveier AS')
  end

  it "An artisan can register hours on the tasks he is delegated" do
    visit artisan_path(@artisan)
    click_link "Nye oppdrag"
    
  end

  
end
