class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy,
                                     :complete]

  before_action :set_by_project_id, only: [:approve_hours, :hours,
                                           :billable_hours, :personal_hours,
                                           :documentation]

  before_action :set_months, only: [:billable_hours, :personal_hours]
  before_action :fetch_hours, only: [:approve_hours]

  after_action :authorize_project,
    :except => [:index, :show, :set_project, :set_by_project_id, :set_favorite]
  after_action :verify_authorized,
    :except => [:index, :show, :set_project, :set_by_project_id, :set_favorite]

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
    authorize @project
  end



  # GET /projects/1/edit
  def edit
    authorize @project
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.user = @current_user
    authorize @project

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
    authorize @project
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
    authorize @project
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  # POST /projects/1
  # POST /projects/1.json
  def complete
    authorize @project
    @project.complete! if authorize @project
    CompleteProjectWorker.perform_async(@project.id)
    respond_to do |format|
      format.html { redirect_to customer_projects_url(@project.customer) }
      format.json { head :no_content }
    end
  end

  def hours
    authorize @project
  end

  def personal_hours
    authorize :project, :personal_hours?
    fetch_hours(of_kind: :personal)
  end

  def billable_hours
    authorize :project, :personal_hours?
    fetch_hours(of_kind: :billable)
  end

  def documentation
    authorize @project
  end


  private

  def authorize_project
    authorize @project
  end

  def set_year_and_month
    authorize @project
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

  def fetch_hours(of_kind:)
    set_year_and_month
    if params[:show_all].present?
      @hours = @project.hours_for_all_users(of_kind: of_kind)
    else
      @hours = @project.hours_for_all_users(month_nr: @month, year: @year,
                                            of_kind: of_kind)
    end
    @hours_not_approved = @hours.any? { |h| h.approved == false }
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
