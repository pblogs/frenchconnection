require 'spec_helper'

describe HoursSpent::ChangesController do
  let(:valid_attributes) do
    { 
      hours_spent: Fabricate(:hours_spent)
    }
  end

  before do
    sign_in
  end

  let(:valid_session) { {} }
  before(:each) { Change.destroy_all }

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested change" do
        pending "WIP"
        change = Change.create! valid_attributes
        Change.any_instance.should_receive(:update).with({ "name" => "MyString" })
        put :update, {:id => change.id,
                      :change => { "overtime_50" => "5" }}, valid_session
      end
    end
  end
end

