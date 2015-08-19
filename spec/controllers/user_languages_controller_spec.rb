require 'rails_helper'


RSpec.describe UserLanguagesController, type: :controller do

  before do
    @user = Fabricate(:user, roles: [:project_leader])
    sign_in @user
  end

  let(:valid_attributes) do
    @user2 = Fabricate(:user, roles: [:project_leader])
    h = Fabricate.create(:user_language, user: @user2).serializable_hash
    UserLanguage.find(h['id']).destroy
    h.delete('id')
    h
  end

  let(:valid_session) { {} }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UserLanguagesController. Be sure to keep this updated too.

  describe "GET #index" do
    it "assigns all user_languages as @user_languages" do
      UserLanguage.destroy_all
      user_language = UserLanguage.create! valid_attributes
      get :index, {:user_id => @user}, valid_session
      expect(assigns(:user_languages)).to eq([user_language])
    end
  end

  describe "GET #show" do
    it "assigns the requested user_language as @user_language" do
      user_language = UserLanguage.create! valid_attributes
      get :show, {:user_id => @user, :id => user_language.to_param},
        valid_session
      expect(assigns(:user_language)).to eq(user_language)
    end
  end

  describe "GET #new" do
    it "assigns a new user_language as @user_language" do
      get :new, {user_id: @user}, valid_session
      expect(assigns(:user_language)).to be_a_new(UserLanguage)
    end
  end

  describe "GET #edit" do
    it "assigns the requested user_language as @user_language" do
      user_language = UserLanguage.create! valid_attributes
      get :edit, {:user_id => @user, :id => user_language.to_param}, valid_session
      expect(assigns(:user_language)).to eq(user_language)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new UserLanguage" do
        expect {
          post :create, {:user_id => @user, :user_language => valid_attributes}, valid_session
        }.to change(UserLanguage, :count).by(1)
      end

      it "assigns a newly created user_language as @user_language" do
        post :create, {:user_id => @user, :user_language => valid_attributes}, valid_session
        expect(assigns(:user_language)).to be_a(UserLanguage)
        expect(assigns(:user_language)).to be_persisted
      end

      it "redirects to the user_language list" do
        post :create, {:user_id => @user, :user_language => valid_attributes}, valid_session
        expect(response).to redirect_to(user_user_languages_path(@user))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved user_language as @user_language" do
        post :create, {:user_id => @user, :user_language => invalid_attributes}, valid_session
        expect(assigns(:user_language)).to be_a_new(UserLanguage)
      end

      it "re-renders the 'new' template" do
        post :create, {user_id: @user, :user_language => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        @user2 = Fabricate(:user, roles: [:project_leader])
        h = Fabricate.create(:user_language, user: @user2).serializable_hash
        h.delete('id')
        h
      end
      #let(:new_attributes) {
      #  skip("Add a hash of attributes valid for your model")
      #}

      it "updates the requested user_language" do
        user_language = UserLanguage.create! valid_attributes
        put :update, {:user_id => @user, :id => user_language.to_param,
                      :user_language => new_attributes}, valid_session
        user_language.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested user_language as @user_language" do
        user_language = UserLanguage.create! valid_attributes
        put :update, {:user_id => @user, :id => user_language.to_param,
                      :user_language => valid_attributes}, valid_session
        expect(assigns(:user_language)).to eq(user_language)
      end

      it "redirects to the user_language" do
        user_language = UserLanguage.create! valid_attributes
        put :update, {:user_id => @user, :id => user_language.to_param,
                      :user_language => valid_attributes}, valid_session
        expect(response).to redirect_to(user_user_languages_url(@user))
      end
    end

    context "with invalid params" do
      it "assigns the user_language as @user_language" do
        user_language = UserLanguage.create! valid_attributes
        put :update, {:user_id => @user, :id => user_language.to_param,
                      :user_language => invalid_attributes}, valid_session
        expect(assigns(:user_language)).to eq(user_language)
      end

      it "re-renders the 'edit' template" do
        user_language = UserLanguage.create! valid_attributes
        put :update, {:user_id => @user, :id => user_language.to_param,
                      :user_language => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user_language" do
      user_language = UserLanguage.create! valid_attributes
      expect {
        delete :destroy, {:user_id => @user,
                          :id => user_language.to_param}, valid_session
      }.to change(UserLanguage, :count).by(-1)
    end

    it "redirects to the user_languages list" do
      user_language = UserLanguage.create! valid_attributes
      delete :destroy, {:user_id => @user,
                        :id => user_language.to_param}, valid_session
      expect(response).to redirect_to(user_user_languages_url(@user))
    end
  end

end
