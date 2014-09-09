class Customers::ProjectsController < ApplicationController
  before_action :set_project,  only: [:show, :edit, :update, :destroy]
  before_action :set_customer, only: [:index, :show, :edit, :update, 
                                      :destroy, :new]


  # GET /projects
  # GET /projects.json
  def index
    @projects = @customer.projects.all
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @departments         = Department.all
  end


  # GET /projects/new
  def new
    @project     = @customer.projects.new
    @customers   = Customer.all
    @departments = Department.all
  end

  # GET /projects/1/edit
  def edit
    @departments         = Department.all
  end

  # POST /projects
  # POST /projects.json
  def create
    @project             = Project.new(project_params)
    @project.user        = @current_user
    @departments         = Department.all

    # TODO make so that this param is sent under the project hash
    #@project.department_id = params[:department]

    @project.customer_id = params[:customer_id] if params[:customer_id].present?
    @customers           = Customer.all
    @customer            = Customer.find(params[:customer_id])

    respond_to do |format|
      if @project.save

        if params[:attachments]
          params[:attachments].each do |attachment| 
            @project.attachments.create!(document: attachment, 
                                         project: @project)
          end
        end

        format.html { redirect_to customer_project_path(@project.customer, 
                        @project), notice: 'Prosjektet ble lagret' }
        format.json { render action: 'show', status: :created, 
                      location: @project }
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
    @departments         = Department.all
    respond_to do |format|
      if @project.update(project_params)

        if params[:attachments]
          params[:attachments].each do |attachment| 
            @project.attachments.create!(document: attachment)
          end
        end

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
    params.require(:project).permit(
                                    :attachments,
                                    :billing_address, 
                                    :customer_reference, 
                                    :company_id,
                                    :comment, 
                                    :customer_id,
                                    :due_date,
                                    :description,
                                    :department_id,
                                    :delivery_address, 
                                    :execution_address, 
                                    :name, 
                                    :project_number, 
                                    :sms_employee_if_hours_not_registered, 
                                    :sms_employee_when_new_task_created,
                                    :starred,
                                    :start_date,
                                    :short_description,
                                    :title,
                                    )
  end
end
