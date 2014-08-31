require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe HoursSpentsController do

  # This should return the minimal set of attributes required to create a valid
  # HoursSpent. As you add validations to HoursSpent, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    { 
      task_id:     Fabricate(:task).id,
      hour:        rand(200..450),
      description: 'Sparklet dritbra',
      date: '2014-04-14',
      user_id: Fabricate(:user, first_name: 'John', last_name: 'Jonassen', department: Fabricate(:department), emp_id: "12121", roles: ["project_leader"]).id
    }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # HoursSpentsController. Be sure to keep this updated too.
  let(:valid_session) { {} }
  before(:each) { HoursSpent.destroy_all ; Customer.destroy_all }

  describe "GET index" do
    it "assigns all hours_spents as @hours_spents" do
      sign_in
      hours_spent = HoursSpent.create! valid_attributes
      get :index, {}, valid_session
      assigns(:hours_spents).should eq([hours_spent])
    end
  end

  describe "GET show" do
    it "assigns the requested hours_spent as @hours_spent" do
      sign_in
      hours_spent = HoursSpent.create! valid_attributes
      get :show, {:id => hours_spent.to_param}, valid_session
      assigns(:hours_spent).should eq(hours_spent)
    end
  end

  describe "GET new" do
    it "assigns a new hours_spent as @hours_spent" do
      sign_in
      get :new, {}, valid_session
      assigns(:hours_spent).should be_a_new(HoursSpent)
    end
  end

  describe "GET edit" do
    it "assigns the requested hours_spent as @hours_spent" do
      sign_in
      hours_spent = HoursSpent.create! valid_attributes
      get :edit, {:id => hours_spent.to_param}, valid_session
      assigns(:hours_spent).should eq(hours_spent)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new HoursSpent" do
        sign_in
        expect {
          post :create, {:hours_spent => valid_attributes}, valid_session
        }.to change(HoursSpent, :count).by(1)
      end

      it "assigns a newly created hours_spent as @hours_spent" do
        sign_in
        post :create, {:hours_spent => valid_attributes}, valid_session
        assigns(:hours_spent).should be_a(HoursSpent)
        assigns(:hours_spent).should be_persisted
      end

      it "redirects to the created hours_spent" do
        sign_in
        post :create, {:hours_spent => valid_attributes}, valid_session
        response.should redirect_to(HoursSpent.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved hours_spent as @hours_spent" do
        sign_in
        # Trigger the behavior that occurs when invalid params are submitted
        HoursSpent.any_instance.stub(:save).and_return(false)
        post :create, {:hours_spent => { "hour" => "invalid value" }}, 
          valid_session
        assigns(:hours_spent).should be_a_new(HoursSpent)
      end

      it "re-renders the 'new' template" do
        sign_in
        # Trigger the behavior that occurs when invalid params are submitted
        HoursSpent.any_instance.stub(:save).and_return(false)
        post :create, {:hours_spent => { "hour" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested hours_spent" do
        sign_in
        hours_spent = HoursSpent.create! valid_attributes
        # Assuming there are no other hours_spents in the database, this
        # specifies that the HoursSpent created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        customer_id = Fabricate(:customer).id.to_s
        HoursSpent.any_instance.should_receive(:update).with({ "customer_id" => customer_id })
        put :update, {:id => hours_spent.to_param, :hours_spent => { "customer_id" => customer_id }}, valid_session
      end

      it "assigns the requested hours_spent as @hours_spent" do
        sign_in
        hours_spent = HoursSpent.create! valid_attributes
        put :update, {:id => hours_spent.to_param, :hours_spent => valid_attributes}, valid_session
        assigns(:hours_spent).should eq(hours_spent)
      end

      it "redirects to the hours_spent" do
        sign_in
        hours_spent = HoursSpent.create! valid_attributes
        put :update, {:id => hours_spent.to_param, :hours_spent => valid_attributes}, valid_session
        response.should redirect_to(hours_spent)
      end
    end

    describe "with invalid params" do
      it "assigns the hours_spent as @hours_spent" do
        sign_in
        hours_spent = HoursSpent.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        HoursSpent.any_instance.stub(:save).and_return(false)
        put :update, {:id => hours_spent.to_param, :hours_spent => { "hour" => "invalid value" }}, valid_session
        assigns(:hours_spent).should eq(hours_spent)
      end

      it "re-renders the 'edit' template" do
        sign_in
        hours_spent = HoursSpent.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        HoursSpent.any_instance.stub(:save).and_return(false)
        put :update, {:id => hours_spent.to_param, :hours_spent => { "hour" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested hours_spent" do
      sign_in
      hours_spent = HoursSpent.create! valid_attributes
      expect {
        delete :destroy, {:id => hours_spent.to_param}, valid_session
      }.to change(HoursSpent, :count).by(-1)
    end

    it "redirects to the hours_spents list" do
      sign_in
      hours_spent = HoursSpent.create! valid_attributes
      delete :destroy, {:id => hours_spent.to_param}, valid_session
      response.should redirect_to(hours_spents_url)
    end
  end

end
