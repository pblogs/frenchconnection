require 'spec_helper'

describe UsersController, :type => :controller do

  before do
    @user = Fabricate(:user)
    sign_in @user
  end

  let(:valid_attributes) do
    Fabricate.build(:user, first_name: 'Bobb Builder')
        .serializable_hash
        .merge(encrypted_password: 'XXX')
        .merge(department_id: 1)
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
        expect {
          post :create, {:user => valid_attributes}, valid_session
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, {:user => valid_attributes}, valid_session
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end

      it "redirects to the created user" do
        post :create, {:user => valid_attributes}, valid_session
        lastname_letter = User.last.last_name[0]
        response.should redirect_to(users_path(letter: lastname_letter))
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
        user = User.create! valid_attributes
        # Assuming there are no other users in the database, this
        # specifies that the User created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        User.any_instance.should_receive(:update).with({ "first_name" => "John" })
        put :update, {
          :id => user.to_param, :user => { "first_name" => "John" }}, valid_session
      end

      it "assigns the requested user as @user" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        assigns(:user).should eq(user)
      end

      it "redirects to the users list" do
        user = User.create! valid_attributes
        put :update, {:id => user.to_param, :user => valid_attributes}, valid_session
        lastname_letter = user.last_name[0]
        response.should redirect_to(users_path(letter: lastname_letter))
      end
    end
  end
end
