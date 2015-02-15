class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy, 
                                     :hours, :complete]

  before_action :set_by_project_id, only: [:approve_hours]

  before_action :set_months, only: [:hours]
  before_action :fetch_hours, only: [:hours, :approve_hours]

  # GET /projects
  # GET /projects.json
  def index
    @departments        = @current_user.project_departments
    @starred_projects   = Project.favored_by(@current_user)
    @starred_customers  = Customer.favored_by(@current_user)
    @completed_projects = Project.where(user: @current_user, complete: true)
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    redirect_to customer_project_path(@project.customer, @project)
  end

  # GET /projects/new
  def new
    @project = Project.new
  end


  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        set_favorite
        format.html { redirect_to @project,
                      notice: 'Prosjektet ble lagret' }
        format.json { render action: 'show', status: :created, 
                      location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, 
                      status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        set_favorite
        format.html { redirect_to @project, 
                      notice: I18n.t('saved') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, 
                      status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  # POST /projects/1
  # POST /projects/1.json
  def complete
    @project.complete!
    CompleteProjectWorker.perform_async(@project.id)
    respond_to do |format|
      format.html { redirect_to customer_projects_url(@project.customer) }
      format.json { head :no_content }
    end
  end

  def hours
  end

  # project_approve_hours 
  # GET    /projects/:project_id/approve_hours       projects#approve_hours
  #
  # FIXME It's not possible to approve all hours from the project view.
  # One must click into users/240/projects/21/hours to approve
  # 
  #def approve_hours
  #  @hours.each { |h| h.hour_object.approve! }
  #  redirect_to hours_path(@project, month: @month, year: @year)
  #end

  private

  def set_year_and_month
    if params[:date].present?
      @year  = params[:date][:year].to_i
      @month = params[:date][:month].to_i
    elsif params[:year].present?
      @year  = params[:year].to_i
      @month = params[:month].to_i
    else
      @year  = Time.now.year
      @month = Time.now.month
    end
  end

  def set_months
    @months = (1..12).to_a
  end
  
  def fetch_hours
    set_year_and_month 
    if params[:show_all].present?
      @hours = @project.hours_for_all_users
    else
      @hours = @project.hours_for_all_users(month_nr: @month, year: @year)
    end
    @some_hours_not_approved = @hours.any? { |h| h.approved == false }
  end

  def set_project
    @project = Project.find(params[:id])
  end

  def set_by_project_id
    @project = Project.find(params[:project_id])
  end

  def project_params
    params.require(:project).permit(:project_number, 
                                    :attachment,
                                    :billing_address, 
                                    :customer_id,
                                    :customer_reference, 
                                    :comment, 
                                    :delivery_address, 
                                    :due_date,
                                    :description,
                                    :execution_address, 
                                    :name, 
                                    :department_id,
                                    :start_date,
                                    :company_id
                                   )
  end

  def set_favorite
    if params[:starred]
      @current_user.favorites << @project.set_as_favorite
    else
      @project.unset_favorite(@current_user)
    end
  end
end
