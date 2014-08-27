class Customers::ProjectsController < ApplicationController
  before_action :set_project,  only: [:show, :edit, :update, :destroy]
  before_action :set_customer, only: [:index, :show, :edit, :update, :destroy, :new]

  # GET /projects
  # GET /projects.json
  def index
    @projects = @customer.projects.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end


  # GET /projects/new
  def new
    @project   = @customer.projects.new
    @customers = Customer.all
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project             = Project.new(project_params)
    @project.user        = @current_user
    @project.customer_id = params[:customer_id] if params[:customer_id].present?
    @customers           = Customer.all
    @customer            = Customer.find(params[:customer_id])

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project,
                      notice: 'Prosjektet ble lagret' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'edit' }
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
        format.html { redirect_to [@project.customer, @project], 
                      notice: 'Project was successfully updated.' }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    def set_customer
      @customer = Customer.find(params[:customer_id])
    end

    def project_params
      params.require(:project).permit(:project_number, :name, 
        :customer_id, :start_date, :due_date, :description,
        :sms_employee_if_hours_not_registered,
        :sms_employee_when_new_task_created)
    end
end
