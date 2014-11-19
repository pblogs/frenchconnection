class Customers::ProjectsController < ApplicationController
  before_action :set_project,  only: [:show, :edit, :update, :destroy]
  before_action :set_customer, only: [:index, :show, :edit, :update, 
                                      :destroy, :new]


  def index
    @projects = @customer.projects.active.all
  end

  def show
    @departments = Department.all
  end

  def new
    @project     = @customer.projects.new
    @customers   = Customer.all
    @departments = Department.all
  end

  def edit
    @departments = Department.all
  end

  def create
    @project      = Project.new(project_params)
    @project.user = @current_user
    @departments  = Department.all

    @project.customer_id = params[:customer_id] if params[:customer_id].present?
    @customers           = Customer.all
    @customer            = Customer.find(params[:customer_id])

    if @project.single_task? && @project.valid?
      @task = @project.build_single_task
    end

    respond_to do |format|
      if @project.save
        if params[:attachments]
          params[:attachments].each_with_index do |attachment, i|
            @project.attachments.create!(document: attachment,
                                         description: params[:att_descriptions][i],
                                         project: @project)
          end
        end

        format.html do
          if @project.single_task?
            redirect_to edit_project_task_path(@project, @task),
              notice: 'Prosjektet ble lagret'
          else
            redirect_to customer_project_path(@project.customer,
                                              @project),
                                              notice: 'Prosjektet ble lagret'
          end
        end
        format.json { render action: 'show', status: :created, 
                      location: @project }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, 
                      status: :unprocessable_entity }
      end
    end
  end

  def update
    @departments = Department.all
    respond_to do |format|
      if @project.update(project_params)

        if params[:attachments]
          params[:attachments].each_with_index do |attachment, i|
            @project.attachments.create!(document: attachment,
                                         description: params[:att_descriptions][i])
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
                                    :single_task
                                    )
  end
end
