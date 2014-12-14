class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :complete]
  before_action :set_task_by_task_id, 
    only: [:save_and_order, :select_inventory, :qualified_workers, 
           :selected_workers, :select_workers, :remove_selected_worker,
           :selected_inventories, :remove_selected_inventory]

  before_action :set_customer, only: [:new, :create, :index]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all.to_a
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @hours_registered = @task.hours_spents.where(user: @current_user).all
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
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
    @task_types = TaskType.all
  end

  def save_and_order
    # TODO Mark the task as reviewed and saved here. Order resources.
    redirect_to(customer_project_path(@task.project.customer, @task.project),
                notice: 'Task saved and the required resources are ordered.')
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task_types = TaskType.all
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
        format.html { redirect_to @task, 
          notice: "Oppdraget ble opprettet og sendt til #{@task.name_of_users}"
          }
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

  # POST /tasks/1/complete
  def complete
    @user_task = @task.user_tasks.find_by(user: current_user)
    @user_task.complete!
    respond_to do |format|
      format.html { redirect_to current_user }
      format.json { head :no_content }
    end
  end

  # POST :select_inventory, { task_id: task.id, inventory_id: inventory.id }
  def select_inventory
    @task.inventories << Inventory.find(params[:inventory_id])
    @task.save
    render json: @task
  end

  def qualified_workers
    render json: @task.qualified_workers.uniq
  end

  def selected_workers
    render json: @task.users.uniq
  end

  def select_workers
    @task.users << User.find(params[:worker_id])
    @task.save
    render json: @task.users
  end

  def remove_selected_worker
    @task.users.delete User.find(params[:worker_id])
    @task.save
    render json: @task
  end

  def selected_inventories
    render json: @task.inventories.uniq
  end

  def remove_selected_inventory
    @task.inventories.delete Inventory.find(params[:inventory_id])
    @task.save
    render json: @task
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # TODO decent_exposure gem is probably better
    def set_task
      @task = Task.find(params[:id])
    end

    def set_customer
      @customer = Customer.find(params[:customer_id]) if params[:customer_id].present?
    end

    def set_task_by_task_id
      @task = Task.find(params[:task_id])
    end


    def task_params
      params.require(:task).permit(:customer_id, 
                                   :task_type_id, 
                                   :start_date, 
                                   :due_date,
                                   :paint_id,
                                   :description,
                                   :project_id,
                                   :user_id,
                                   :department_id, 
                                   :user_ids => []
                                  )
    end
end
