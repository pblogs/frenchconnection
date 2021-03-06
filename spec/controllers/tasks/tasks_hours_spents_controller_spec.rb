require 'spec_helper'


describe Tasks::HoursSpentsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # HoursSpent. As you add validations to HoursSpent, be sure to
  before do
    @project = Fabricate(:project)
    @task = Fabricate(:task, project: @project)
    @user = Fabricate(:user)
  end
  # attrs = FactoryGirl.attributes_for(:description, :thing_id => @thing)
  # adjust the attributes here as well.
  let(:valid_attributes) do
    {
      task_id: @task.id,
      hour: rand(200..450),
      description: 'Sparklet dritbra',
      date: '2014-04-14',
      user_id: @user.id,
      project_id: @project.id,
    }
  end

  let(:valid_session) { {} }

  describe "GET index" do
    #before do
    #  @new_hours = @project.hour.personal.not_frozen.year(2015).month(1)
    #  @billable_approved_hours = @project.hours_spent.billable.approved.year(2015).month(1)
    #  @billable_not_approved_hours = @project.hours_spent
    #    .billable.not_approved.year(2015).month(1)
    #end
    it "assigns all hours_spents as @hours" do
      sign_in(@user)
      hours_spent = HoursSpent.create! valid_attributes
      hours_spent.project.update_attribute(:complete, true)
      get :index, {task_id: @task.id}, valid_session
      assigns(:hours).should eq([hours_spent])
    end
  end

  # Not using show, I think
  describe "GET show" do
    it "assigns the requested hours as @hours" do
    pending "Not using show, I think"
      sign_in(@user)
      hours = HoursSpent.create! valid_attributes
      get :show, { :task_id => @task.id, :id => hours.to_param}, valid_session
      assigns(:hours).should eq(hours)
    end
  end

  describe "GET new" do
    it "assigns a new hours_spent as @hours_spent" do
      sign_in(@user)
      get :new, { :task_id => @task.id }, valid_session
      assigns(:hour).should be_a_new(HoursSpent)
    end
  end

  describe "GET edit" do
    it "assigns the requested hours_spent as @hours_spent" do
      sign_in(@user)
      hours_spent = HoursSpent.create! valid_attributes
      get :edit, {:task_id => @task.id, :id => hours_spent.to_param}, valid_session
      assigns(:hour).should eq(hours_spent)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a both a personal and billable HoursSpent" do
        sign_in(@user)
        expect {
          post :create, {:task_id => @task.id,
                         :hours_spent => valid_attributes}, valid_session
        }.to change(HoursSpent, :count).by(2)
      end

      it "assigns a newly created hour as @hour" do
        sign_in(@user)
        post :create, {:task_id => @task.id,
                       :hours_spent => valid_attributes}, valid_session
        assigns(:hour).should be_a(HoursSpent)
        assigns(:hour).should be_persisted
      end

      it "redirects to My Page, so the user can report more hours" do
        sign_in(@user)
        post :create, {:task_id => @task.id,
                       :hours_spent => valid_attributes}, valid_session
        response.should redirect_to(@user)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved hour as @hour" do
        sign_in
        # Trigger the behavior that occurs when invalid params are submitted
        HoursSpent.any_instance.stub(:save).and_return(false)
        post :create, { :task_id => @task.id,
                        :hours_spent => {"hour" => "invalid value"}},
          valid_session
        assigns(:hour).should be_a_new(HoursSpent)
      end

      it "re-renders the 'new' template" do
        sign_in
        # Trigger the behavior that occurs when invalid params are submitted
        HoursSpent.any_instance.stub(:save).and_return(false)
        post :create, {:task_id => @task.id,
                       :hours_spent => {"hour" => "invalid value"}},
        valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested hour" do
        sign_in(@user)
        hour = HoursSpent.create! valid_attributes
        # Assuming there are no other hours_spents in the database, this
        # specifies that the HoursSpent created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        customer_id = Fabricate(:customer).id.to_s
        HoursSpent.any_instance.should_receive(:update)
          .with({"customer_id" => customer_id})
        put :update, { :task_id => @task.id, :id => hour.to_param,
                       :hours_spent => {"customer_id" => customer_id}}, valid_session
      end

      it "assigns the requested hour as @hour" do
        sign_in(@user)
        hour = HoursSpent.create! valid_attributes
        put :update, { :task_id => @task.id, :id => hour.to_param,
                       :hours_spent => valid_attributes}, valid_session
        assigns(:hour).should eq(hour)
      end

      it "redirects to the hour" do
        sign_in(@user)
        hour = HoursSpent.create! valid_attributes
        put :update, { :task_id => @task.id, :id => hour.to_param,
                       :hours_spent => valid_attributes}, valid_session
        response.should redirect_to(hour.task)
      end
    end

    describe "with invalid params" do
      it "assigns the hour as @hour" do
        sign_in(@user)
        hour = HoursSpent.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        HoursSpent.any_instance.stub(:save).and_return(false)
        put :update, { :task_id => @task.id, :id => hour.to_param,
                       :hours_spent => {"hour" => "invalid value" } }, valid_session
        assigns(:hour).should eq(hour)
      end

      it "re-renders the 'edit' template" do
        sign_in(@user)
        hour = HoursSpent.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        HoursSpent.any_instance.stub(:save).and_return(false)
        put :update, { :task_id => @task.id, :id => hour.to_param,
                       :hours_spent => {"hour" => "invalid value"}},
        valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested hour" do
      sign_in(@user)
      hour = HoursSpent.create! valid_attributes
      expect {
        delete :destroy, { :task_id => hour.task.id,
                           :id => hour.to_param}, valid_session
      }.to change(HoursSpent, :count).by(-1)
    end

    it "redirects to the hours_spents list" do
      sign_in(@user)
      hour = HoursSpent.create! valid_attributes
      delete :destroy, { :task_id => @task.id, :id => hour.to_param},
        valid_session
      response.should redirect_to(hours_spents_url)
    end
  end

end
