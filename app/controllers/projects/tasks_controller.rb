class Projects::TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :set_customer, only: [:new, :create, :index]

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
    @users_in_our_department = @current_user.department.users.all
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    @project = Project.find(params[:project_id])
    @departments = Department.all
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @paint      = Paint.all
    @task       = Task.new(task_params)
    @project    = Project.find(params[:project_id])
    @task.project = @project 
    @departments = Department.all

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

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to customer_project_path(@task.project.customer, 
                                                        @task.project),
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


    def task_params
      params.require(:task).permit(:customer_id, 
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
