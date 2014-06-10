class Projects::TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_customer, only: [:new, :create, :index]
  before_action :set_paint_and_type, only: [:new, :edit, :create]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
  end

  # GET /tasks/1
  # GET /tasks/1.json
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

  # GET /tasks/new
  def new
    @project = Project.find(params[:project_id])
    @departments = Department.all
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    @task_types = TaskType.all
    @departments = Department.all
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task_types = TaskType.all
    @paint      = Paint.all
    @task       = Task.new(task_params)
    @project    = Project.find(params[:project_id])
    @task.project = @project 


    begin
      @task.task_type = TaskType.find(params[:task][:task_type_id]).first
    rescue
    end

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task.project, 
          notice: "Oppdraget ble opprettet" }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, 
                      status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, 
                      notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    def set_customer
      @customer = Customer.find(params[:customer_id]) if params[:customer_id].present?
    end

    def set_paint_and_type
      @task_types = TaskType.all
      @paint      = Paint.all
      @workers    = User.workers.all
    end

    def task_params
      params.require(:task).permit(:customer_id, 
                                   :task_type_id, 
                                   :start_date, 
                                   :due_date,
                                   :paint_id,
                                   :description,
                                   :customer_buys_supplies,
                                   :department_id, 
                                   :user_ids => []
                                  )
    end
end
