require 'spec_helper'

describe UsersController, :type => :controller do

  before do
    @user = Fabricate(:user)
    sign_in @user
  end

  let(:valid_attributes) do
    Fabricate.build(:user).serializable_hash
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UsersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET show" do
    it "assigns the requested task as @tasks" do
      tasks = [Fabricate(:task), Fabricate(:task)]
      tasks.each { 
        |t| t.users << @user 
        @user.user_tasks.where(task_id: t.id).first.confirm!
      }
      get :show, {id: @user.to_param}, valid_session
      assigns(:tasks).should include(*tasks)
    end
  end

  describe "GET new" do
    it "assigns a new user as @user" do
      sign_in
      get :new, {}, valid_session
      assigns(:user).should be_a_new(User)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        pending
        valid_attributes['department_id'] = 1
        expect {
          post :create, {:user => valid_attributes}, valid_session
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user", focus: true do
        pending
        valid_attributes['department_id'] = 1
        post :create, {:user => valid_attributes}, valid_session
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end

      it "redirects to the created user" do
        valid_attributes['department_id'] = 1
        post :create, {:user => valid_attributes}, valid_session
        response.should redirect_to(User.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, {:user => { "name" => "invalid value" }}, valid_session
        assigns(:user).should be_a_new(User)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, {:user => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested user" do
        pending
        valid_attributes['department_id'] = 1
        user = User.create! valid_attributes
        # Assuming there are no other users in the database, this
        # specifies that the User created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        User.any_instance.should_receive(:update).with({ "name" => "MyString" })
        put :update, {:id => user.to_param, :user => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested user as @user" do
        pending
        valid_attributes['department_id'] = 1
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        assigns(:user).should eq(user)
      end

      it "redirects to the user" do
        valid_attributes['department_id'] = 1
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        response.should redirect_to(user)
      end
    end
  end
end
