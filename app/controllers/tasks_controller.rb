class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy, :complete]
  before_action :set_task_by_task_id,
    only: [:save_and_order_resources, :select_inventory, :qualified_workers,
           :selected_workers, :select_workers, :remove_selected_worker,
           :inventories,
           :selected_inventories, :remove_selected_inventory]

  before_action :set_customer, only: [:new, :create, :index]
  before_action :authorize_task, :except => [:index, :show, :task, :edit, :new, :create]
  after_action :verify_authorized, :except => [:index, :show, :task, :edit]

  def index
    @tasks = Task.all.to_a
  end

  def show
    if @task.project.complete?
      @hours = @task.hours_spents.personal.all
    else
      @hours = @task.hours_spents.billable.all
    end
  end

  def active
    @tasks = Task.where(accepted: true, finished: false)
      .order(created_at: :desc)
    render :index
  end

  def report
    @tasks = Task.all.where(accepted: true)
    @customers = Customer.all
  end


  def edit
  end

  def save_and_order_resources
    if @task.save_and_order_resources!
      redirect_to(customer_project_path(@task.project.customer, @task.project),
        notice: I18n.t('task.saved_resources_ordered'))
    else
      redirect_to(customer_project_path(@task.project.customer, @task.project),
        warning: I18n.t('could_not_save'))
    end
  end

  def create
    @task = Task.new(task_params)
    @task.owner = @current_user
    authorize @task

    if params[:customer_id].present?
      @task.customer  = Customer.find(params[:customer_id])
    elsif params[:task][:customer_id].present?
      @task.customer  = Customer.find(params[:task][:customer_id])
    end

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task.project,
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

  def update
    respond_to do |format|
      @task.owner = @current_user
      if @task.update(task_params)
        format.html { redirect_to @task.project,
                      notice: 'Oppgaven lagret' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @task
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  def complete
    authorize @task
    @user_task = @task.user_tasks.find_by(user: current_user)
    @user_task.complete!
    respond_to do |format|
      format.html { redirect_to current_user }
      format.json { head :no_content }
    end
  end

  # POST :select_inventory, { task_id: task.id, inventory_id: inventory.id }
  def select_inventory
    unless @task.inventory_ids.include? params[:inventory_id].to_i
      @task.inventories << Inventory.find(params[:inventory_id])
      @task.save
    end
    render json: @task
  end

  def qualified_workers
    render json: @task.qualified_workers.uniq
  end

  def selected_workers
    render json: @task.users.uniq
  end

  def select_workers
    unless @task.user_ids.include? params[:worker_id].to_i
      @task.users << User.find(params[:worker_id])
      @task.save
    end
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

  def inventories
    inventories = Inventory.all - @task.inventories.to_a
    render json:  inventories
  end

  private

  def authorize_task
    authorize @task
  end


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
    params.require(:task).permit(
                                 :customer_id,
                                 :department_id,
                                 :description,
                                 :due_date,
                                 :owner_id,
                                 :project_id,
                                 :start_date,
                                 :task_type_id,
                                 :user_id,
                                 :user_ids => []
                                )
  end

end
