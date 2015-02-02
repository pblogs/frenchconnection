class Tasks::HoursSpentController < ApplicationController
  before_action :set_hours_spent, only: [:show, :edit, :update, :destroy]
  before_action :set_task

  # GET /hours_spents
  # GET /hours_spents.json
  def index
    @hours_spents = @task.hours_spents.to_a
  end

  # GET /hours_spents/1
  # GET /hours_spents/1.json
  def show
  end

  # GET /hours_spents/new
  def new
    @hours_spent = HoursSpent.new
  end

  # GET /hours_spents/1/edit
  def edit
  end

  # POST /hours_spents
  # POST /hours_spents.json
  def create
    @task = Task.find(params[:task_id])
    @hours_spent         = @current_user.hours_spents.new(hours_spent_params)
    @hours_spent.task    = @task
    @hours_spent.project = @task.project

    respond_to do |format|
      if @hours_spent.save
        format.html { redirect_to @current_user, 
                      notice: 'Timer registert' }
        format.json { render action: 'show', status: :created, 
                      location: @hours_spent }
      else
        format.html { render action: 'new' }
        format.json { render json: @hours_spent.errors, 
                      status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hours_spents/1
  # PATCH/PUT /hours_spents/1.json
  def update
    respond_to do |format|
      if @hours_spent.update(hours_spent_params)
        format.html { redirect_to @hours_spent.task, 
                      notice: 'Endringene er lagret' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @hours_spent.errors, 
                      status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hours_spents/1
  # DELETE /hours_spents/1.json
  def destroy
    @hours_spent.destroy
    respond_to do |format|
      format.html { redirect_to hours_spents_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hours_spent
      @hours_spent = HoursSpent.find(params[:id])
    end

    def hours_spent_params
      params.require(:hours_spent).permit(:customer_id, 
                                          :task_id, 
                                          :user_id,
                                          :project_id,
                                          :overtime_50,
                                          :overtime_100,
                                          :runs_in_company_car,
                                          :km_driven_own_car,
                                          :toll_expenses_own_car,
                                          :supplies_from_warehouse,
                                          :piecework_hours,
                                          :hour, :description, :date)
    end

    def set_task
      @task = Task.find(params[:task_id])
    end
end
