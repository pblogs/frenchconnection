class TasksController < ApplicationController
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


  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    @task_types = TaskType.all
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task_types = TaskType.all
    @paint = Paint.all
    @task = Task.new(task_params)
    if params[:customer_id].present?
      @task.customer  = Customer.find(params[:customer_id])
    elsif params[:task][:customer_id].present?
      @task.customer  = Customer.find(params[:task][:customer_id])
    end

    begin
      @task.task_type = TaskType.find(params[:task][:task_type_id]).first
    rescue
    end

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render action: 'show', status: :created, location: @task }
      else
        format.html { render action: 'new' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
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
      @artisans   = Artisan.all
    end

    def task_params
      params.require(:task).permit(:customer_id, 
                                   :task_type_id, 
                                   :start_date, 
                                   :paint_id,
                                   :artisan_id,
                                   :customer_buys_supplies)
    end
end
