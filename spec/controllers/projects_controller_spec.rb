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

describe ProjectsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Project. As you add validations to Project, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    { 
      project_number:       'P01',
      customer_id:          Fabricate(:customer).id,
      department_id:        Fabricate(:department).id,
      name:                 Faker::Lorem.words(3).join(''),
      start_date:           '01.05.1983',
      due_date:             '01.08.1983',
      description:          'New fence',
    }
  end

  before do
    @user = Fabricate(:user, roles: [:project_leader])
    sign_in @user
    Project.destroy_all
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProjectsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do

    before do
      @bratfos = Fabricate(:department, title: 'Bratfos')
      Fabricate(:project, name: 'not my project')
      @starred_customer = Fabricate(:customer)
      @starred_project = Fabricate(:project, user: @user,
                                  complete: false, department: @bratfos)
      @user.favorites << @starred_customer.set_as_favorite
      @user.favorites << @starred_project.set_as_favorite
      @completed_project = Fabricate(:project, user: @user, complete: true,
                                     department: @bratfos)
    end

    it "lists all departments that the current user has projects in"  do
      Fabricate(:project, user: @user,
                complete: false, department: @bratfos)

      get :index, {}, valid_session
      assigns(:departments).should eq([@bratfos])
    end

    it "assigns starred customers" do
      get :index, {}, valid_session
      assigns(:starred_customers).should  eq([@starred_customer])
    end

    it "assigns starred projects" do
      get :index, {}, valid_session
      assigns(:starred_projects).should  eq([@starred_project])
    end

    it "assigns completed projects" do
      get :index, {}, valid_session
      assigns(:completed_projects).should  eq([@completed_project])
    end

  end


  describe "GET new" do
    it "assigns a new project as @project" do
      get :new, {}, valid_session
      assigns(:project).should be_a_new(Project)
    end
  end

  describe "GET edit" do
    it "assigns the requested project as @project" do
      project = Project.create! valid_attributes
      get :edit, {:id => project.to_param}, valid_session
      assigns(:project).should eq(project)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Project" do
        expect {
          post :create, {:project => valid_attributes}, valid_session
        }.to change(Project, :count).by(1)
      end

      it "assigns a newly created project as @project" do
        post :create, {:project => valid_attributes}, valid_session
        assigns(:project).should be_a(Project)
        assigns(:project).should be_persisted
      end

      it "redirects to the created project" do
        post :create, {:project => valid_attributes}, valid_session
        response.should redirect_to(Project.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved project as @project" do
        # Trigger the behavior that occurs when invalid params are submitted
        Project.any_instance.stub(:save).and_return(false)
        post :create, {:project => { "project_number" => "invalid value" }}, 
          valid_session
        assigns(:project).should be_a_new(Project)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Project.any_instance.stub(:save).and_return(false)
        post :create, {:project => { "project_number" => "invalid value" }}, 
          valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested project" do
        project = Project.create! valid_attributes
        # Assuming there are no other projects in the database, this
        # specifies that the Project created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Project.any_instance.should_receive(:update).with({ "project_number" => "MyString" })
        put :update, {:id => project.to_param, :project => { "project_number" => "MyString" }}, valid_session
      end

      it "assigns the requested project as @project" do
        project = Project.create! valid_attributes
        put :update, {:id => project.to_param, :project => valid_attributes}, valid_session
        assigns(:project).should eq(project)
      end

      it "redirects to the project" do
        project = Project.create! valid_attributes
        put :update, {:id => project.to_param, :project => valid_attributes}, valid_session
        response.should redirect_to(project)
      end
    end

    describe "with invalid params" do
      it "assigns the project as @project" do
        project = Project.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Project.any_instance.stub(:save).and_return(false)
        put :update, {:id => project.to_param, :project => { "project_number" => "invalid value" }}, valid_session
        assigns(:project).should eq(project)
      end

      it "re-renders the 'edit' template" do
        project = Project.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Project.any_instance.stub(:save).and_return(false)
        put :update, {:id => project.to_param, :project => { "project_number" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested project" do
      project = Project.create! valid_attributes
      expect {
        delete :destroy, {:id => project.to_param}, valid_session
      }.to change(Project, :count).by(-1)
    end

    it "redirects to the projects list" do
      project = Project.create! valid_attributes
      delete :destroy, {:id => project.to_param}, valid_session
      response.should redirect_to(projects_url)
    end
  end

  # Prosjektforside: Timeliste: Ny side som lister dager nedover med ansatte 
  # som har levert timer på den dagen.
  #
  describe "List hours registered" do
    before do
      @project   = Fabricate(:project)
      @task      = Fabricate(:task, project: @project)
      @user      = Fabricate(:user)
      @task.users << @user
      @new_hours = Fabricate(:hours_spent, task: @task, of_kind: :personal,
                             description: 'new_hours',
                             date: Time.parse('01.05.2015'))

      @billable_approved = Fabricate(:hours_spent, task: @task, user: @user,
                                     description: 'billable_approved',
                                     hour: 20, change_reason: 'updated',
                                     of_kind: :billable, approved: true,
                                     date: Time.parse('01.05.2015'))

      @billable_not_approved = Fabricate(:hours_spent, task: @task, user: @user,
                                         description: 'billable_not_approved',
                                         hour: 20, change_reason: 'updated',
                                         of_kind: :billable, approved: false,
                                         date: Time.parse('01.05.2015'))
    end

    context 'with :show_all param' do

      context 'billable' do
        it "finds all hours" do
          get :billable_hours, { project_id: @project.id, show_all: 1 }, valid_session
          expect(assigns(:hours)).to eq @project.hours_for_all_users(of_kind: :billable)
        end
      end

      context 'personal' do
        it "finds all hours" do
          get :billable_hours, { project_id: @project.id, show_all: 1 }, valid_session
          expect(assigns(:hours)).to eq @project.hours_for_all_users(of_kind: :billable)
        end
      end
    end

    context 'with date params' do
      before do
        @different_month = Fabricate(:hours_spent, task: @task, of_kind: :personal,
          description: 'new_hours different month', date: Time.parse('01.06.2015'))
      end

      context 'billable' do
        it "populates an array with @hours for the project" do
          get :billable_hours, { project_id: @project.id,
                        date: { year: 2015, month: 5 },
                      }, valid_session
          expect(assigns(:hours)).to eq @project.hours_for_all_users(of_kind: :billable, month_nr: @month, year: @year)
        end
      end

      context 'personal' do
        it "populates an array with @hours for the project" do
          get :personal_hours, { project_id: @project.id,
                        date: { year: 2015, month: 5 },
                      }, valid_session
          expect(assigns(:hours)).to eq @project.hours_for_all_users(of_kind: :personal, month_nr: @month, year: @year)
        end
      end
    end

  end


end
