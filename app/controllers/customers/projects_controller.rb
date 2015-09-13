class Customers::ProjectsController < ApplicationController
  before_action :set_project,  only: [:show, :edit, :update, :destroy]
  before_action :set_customer, only: [:index, :show, :edit, :update,
                                      :destroy, :new]
  before_action :set_departments


  def index
    @projects = @customer.projects.active.all
  end

  def show
    @drafts            = @project.task_drafts
    @tasks_in_progress = @project.tasks_in_progress
    @completed_tasks   = @project.completed_tasks
  end

  def new
    @project     = @customer.projects.new
    @project.attachments.build
    @customers   = Customer.all
  end

  def edit
    @is_favorite = @project.is_favorite_of?(@current_user)
    @project.attachments.build unless @project.attachments.present?
  end

  def create
    @project      = Project.new(project_params)
    @project.user = @current_user

    @project.customer_id = params[:customer_id] if params[:customer_id].present?
    @customers           = Customer.all
    @customer            = Customer.find(params[:customer_id])

    if @project.single_task? && @project.valid?
      @task = @project.build_single_task
    end

    respond_to do |format|
      if @project.save
        set_favorite
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
              notice: I18n.t(:saved)
          else
            redirect_to customer_project_path(@project.customer,
                                              @project),
                                              notice: I18n.t(:saved)
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
    respond_to do |format|
      if @project.update(project_params)
        set_favorite

        format.html { redirect_to [@project.customer, @project],
                      notice: t('updated') }
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

  def set_departments
    @departments = Department.all
  end

  def set_favorite
    if params[:starred]
      @current_user.favorites << @project.set_as_favorite
    else
      @project.unset_favorite(@current_user)
    end
  end

  def project_params
    params.require(:project).permit(
                                    {attachments_attributes: [:document, :description]},
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
                                    :project_reference,
                                    :sms_employee_if_hours_not_registered,
                                    :sms_employee_when_new_task_created,
                                    :start_date,
                                    :title,
                                    :single_task
                                    )
  end
end
