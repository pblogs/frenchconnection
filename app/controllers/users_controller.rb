class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :set_department, only: [:new, :edit, :update, :create]
  before_action :set_profession, only: [:new, :edit, :update, :create]
  before_action :fix_roles_params, only: [:update, :create]

  # GET /users
  # GET /users.json
  def index
    alpha_paginate_options = {
        :support_language => :en,
        :pagination_class => 'pagination-centered',
        :js => false,
        :include_all => false,
        :default_field => get_paginate_default_field(User.order(:last_name)
                                                     .first.last_name[0])
    }
    @users, @alpha_params = User.all.alpha_paginate(params[:letter],
        alpha_paginate_options) { |user| user.last_name }
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @tasks           = Task.from_user(@current_user).by_status(:confirmed).ordered
    @new_tasks       = Task.from_user(@current_user).by_status(:pending).ordered
    @completed_tasks = Task.from_user(@current_user).by_status(:complete).ordered
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @form_action = user_path(@user)
  end

  # GET /users/:user_id/projects/:project_id/hours
  def hours
    @user     = User.find(params[:user_id])
    @project  = Project.find(params[:project_id])
    @projects = @user.projects
    @hours    = @project.hours_spents.where(user: @user)
      .not_frozen_by_admin
      .personal
    @hours += @project.hours_spents.where(user: @user).approved
    @hours += @project.hours_spents.where(user: @user).billable

    # Update all hours as approved. TODO: Use a separate function for this
    if request.post?
      @hours.each { |h| h.update_attribute(:approved, true) }
    end
  end

  def approved_hours
    @user  = User.find(params[:user_id])
    @hours = @project.hours_spents.approved
  end

  def create
    @user = User.new(user_params)
    @user.password = @user.password_confirmation = srand.to_s[0..10]
    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path,
                    notice: I18n.t('saved') }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url,
                    notice: I18n.t('updated') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @user.id == current_user.id
      redirect_to users_url, notice: 'This user cant be deleted.'
    else
      @user.destroy
      flash[:notice] = 'User was successfully deleted.'
      respond_to do |format|
        format.html { redirect_to users_url }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def set_department
      @departments = Department.all
    end

    def set_profession
      @professions = Profession.all
    end

    # Never trust parameters from the scary internet,
    #only allow the white list through.
    def user_params
      params.require(:user).permit(
        :first_name,
        :last_name, 
        :tasks_id,
        :mobile,
        :emp_id,
        :profession_id,
        :department_id,
        :image,
        roles: [],
        skill_ids: [],
        certificate_ids: [])
    end

  def fix_roles_params
    return if params[:user][:roles].blank?
    params[:user][:roles].reject!(&:blank?)
    params[:user][:roles] = params[:user][:roles].collect { |a| a.to_sym }
  end

end
