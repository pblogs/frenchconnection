class Projects::TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_task_from_id, only: [:end_task, :end_task_hard]
  before_action :set_customer, only: [:new, :create, :index]
  before_action :set_workers_and_dates, only: [:edit, :new, :create]

  def index
    @tasks = Task.all
  end

  def show
  end

  def active
    @tasks = Task.where(accepted: true, finished: false).order(created_at: :desc)
    render :index
  end

  def report
    @tasks = Task.all.where(accepted: true)
    @customers = Customer.all
  end

  def new
    @task = Task.new
  end

  def edit
    @departments = Department.all
  end

  def end_task
    @task.end_task(@current_user)
    redirect_to :back, notice: I18n.t('task_ended')
  end

  def end_task_hard
    @task.end_task_hard
    redirect_to :back, notice: I18n.t('task_ended')
  end

  def create
    @paint        = Paint.all
    @task         = Task.new(task_params)
    @project      = Project.find(params[:project_id])
    @task.project = @project
    @departments  = Department.all

    respond_to do |format|
      if @task.save
        format.html { redirect_to customer_project_path(@task.project.customer, 
                                                        @task.project),
          notice: "Oppdraget ble opprettet" }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, 
                      status: :unprocessable_entity }
      end
    end
  end

  def tools
    
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { 
          if params[:task][:goto_tools].present?
            redirect_to project_task_tools_path(@task.project, @task)
          else
            redirect_to customer_project_path(@task.project.customer, 
              @task.project),
              notice: I18n.t('notifications.successfully_updated')
          end
        }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to customer_project_path(@task.project.customer, 
                                                      @task.project,
                                                      anchor: :tasks
                                                     ),
                      notice: I18n.t('task.destroyed')
                      }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = Task.find(params[:id])
  end

  def set_task_from_id
    @task = Task.find(params[:task_id])
  end

  def set_customer
    @customer = Customer.find(params[:customer_id]) if params[:customer_id].present?
  end

  def set_workers_and_dates
    @project  = Project.find(params[:project_id])
    @maxdate  = @project.due_date || Time.now + 10.years.to_i 
    @due_date = @project.due_date || @maxdate
    @users_in_our_department = @current_user.department.users.order(last_name: :asc)
  end

  def task_params
    params.require(:task).permit(:customer_id, 
                                 :start_date, 
                                 :due_date,
                                 :paint_id,
                                 :description,
                                 :work_category_id,
                                 :location_id,
                                 :goto_tools,
                                 :department_id, 
                                 :user_ids => []
                                )
  end
end
