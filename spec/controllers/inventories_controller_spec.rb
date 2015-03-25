require 'spec_helper'


describe InventoriesController, :type => :controller do
  before do
    @user = Fabricate(:user)
    sign_in @user
  end

  # This should return the minimal set of attributes required to create a valid
  # Inventory. As you add validations to Inventory, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "name" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # InventoriesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all inventories as @inventories" do
      inventory = Inventory.create! valid_attributes
      get :index, {}, valid_session
      assigns(:inventories).should eq([inventory])
    end
  end

  describe "GET show" do
    it "assigns the requested inventory as @inventory" do
      inventory = Inventory.create! valid_attributes
      get :show, {:id => inventory.to_param}, valid_session
      assigns(:inventory).should eq(inventory)
    end
  end

  describe "GET new" do
    it "assigns a new inventory as @inventory" do
      get :new, {}, valid_session
      expect(assigns(:inventory)).to be_a_new(Inventory)
    end
  end

  describe "POST search" do
    it 'assignes inventoy matching params[:query] to @inventory' do
      cat_bulldozer = Fabricate(:inventory, name: 'Cat bulldozer')
      get :search, {:q => 'Cat'}, valid_session
      assigns(:inventories).should eq [cat_bulldozer]
    end
  end

  describe "GET edit" do
    it "assigns the requested inventory as @inventory" do
      inventory = Inventory.create! valid_attributes
      get :edit, {:id => inventory.to_param}, valid_session
      assigns(:inventory).should eq(inventory)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Inventory" do
        expect {
          post :create, {:inventory => valid_attributes}, valid_session
        }.to change(Inventory, :count).by(1)
      end

      it "assigns a newly created inventory as @inventory" do
        post :create, {:inventory => valid_attributes}, valid_session
        assigns(:inventory).should be_a(Inventory)
        assigns(:inventory).should be_persisted
      end

      it "redirects to the created inventory" do
        post :create, {:inventory => valid_attributes}, valid_session
        response.should redirect_to(inventories_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved inventory as @inventory" do
        # Trigger the behavior that occurs when invalid params are submitted
        Inventory.any_instance.stub(:save).and_return(false)
        post :create, {:inventory => { "name" => "invalid value" }}, valid_session
        assigns(:inventory).should be_a_new(Inventory)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Inventory.any_instance.stub(:save).and_return(false)
        post :create, {:inventory => { "name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested inventory" do
        inventory = Inventory.create! valid_attributes
        # Assuming there are no other inventories in the database, this
        # specifies that the Inventory created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Inventory.any_instance.should_receive(:update).with({ "name" => "MyString" })
        put :update, {:id => inventory.to_param,
                      :inventory => { "name" => "MyString" }}, valid_session
      end

      it "assigns the requested inventory as @inventory" do
        inventory = Inventory.create! valid_attributes
        put :update, {:id => inventory.to_param,
                      :inventory => valid_attributes}, valid_session
        assigns(:inventory).should eq(inventory)
      end

      it "redirects to the inventory" do
        inventory = Inventory.create! valid_attributes
        put :update, {:id => inventory.to_param,
                      :inventory => valid_attributes}, valid_session
        response.should redirect_to(inventories_path)
      end
    end

    describe "with invalid params" do
      it "assigns the inventory as @inventory" do
        inventory = Inventory.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Inventory.any_instance.stub(:save).and_return(false)
        put :update, {:id => inventory.to_param,
                      :inventory => { "name" => "invalid value" }},
        valid_session
        assigns(:inventory).should eq(inventory)
      end

      it "re-renders the 'edit' template" do
        inventory = Inventory.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Inventory.any_instance.stub(:save).and_return(false)
        put :update, {:id => inventory.to_param,
                      :inventory => { "name" => "invalid value" }},
        valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested inventory" do
      inventory = Inventory.create! valid_attributes
      expect {
        delete :destroy, {:id => inventory.to_param}, valid_session
      }.to change(Inventory, :count).by(-1)
    end

    it "redirects to the inventories list" do
      inventory = Inventory.create! valid_attributes
      delete :destroy, {:id => inventory.to_param}, valid_session
      response.should redirect_to(inventories_url)
    end
  end

end
