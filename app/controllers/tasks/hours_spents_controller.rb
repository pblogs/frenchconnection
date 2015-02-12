module Tasks
  class HoursSpentsController < ApplicationController
    before_action :set_hours_spent, only: [:show, :edit, :update, :destroy]
    before_action :set_by_hours_spent_id, only: [:approve, :for_admin]
    before_action :set_task

    # GET /hours_spents
    # GET /hours_spents.json
    def index
      if @task.project.complete?
        @hours = @task.hours_spents.personal.all
      else
        @hours = @task.hours_spents.billable.all
      end
    end

    # GET /hours_spents/1
    # GET /hours_spents/1.json
    def show
    end

    # GET /hours_spents/new
    def new
      @hour = HoursSpent.new
    end

    # GET /hours_spents/1/edit
    def edit
    end

    # POST /hours_spents
    # POST /hours_spents.json
    def create
      @task                = Task.find(params[:task_id])
      @hour         = @current_user.hours_spents.new(hours_spent_params)
      @hour.task    = @task
      @hour.project = @task.project

      respond_to do |format|
        if @hour.save
          format.html { redirect_to task_hours_spents_path(@task),
                        notice: 'Timer registert' }
          format.json { render action: 'show', status: :created,
                        location: @hour }
        else
          format.html { render action: 'new' }
          format.json { render json: @hour.errors,
                        status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /hours_spents/1
    # PATCH/PUT /hours_spents/1.json
    def update
      respond_to do |format|
        if @hour.update(hours_spent_params)
          format.html { redirect_to @hour.task,
                        notice: 'Endringene er lagret' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @hour.errors,
                        status: :unprocessable_entity }
        end
      end
    end


    # DELETE /hours_spents/1
    # DELETE /hours_spents/1.json
    def destroy
      @hour.destroy
      respond_to do |format|
        format.html { redirect_to hours_spents_url }
        format.json { head :no_content }
      end
    end

    def approve
      @hour.approve!
      redirect_to user_hours_path(@hour.user, @hour.project)
    end

    # hours_spent_for_admin 
    # POST   /hours_spents/:hours_spent_id/for_admin(.:format) 
    # GET    /hours_spents/:hours_spent_id/for_admin(.:format)
    # PATCH  /hours_spents/:hours_spent_id/for_admin(.:format)
    def for_admin
      if request.patch? 
        if @hour.personal?
          @new_hour = create_billable_hour
          @hour.update_attribute(:frozen_by_admin, true) if @new_hour.save!
        elsif @hour.billable?
          @hour.update(hours_spent_params)
        end

      end
      redirect_to user_hours_path(@hour.user, @hour.project)
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_hours_spent
      @hour = HoursSpent.find(params[:id])
    end

    def create_billable_hour
      new_hour = HoursSpent.new(@hour.attributes
        .except('id', 'created_at', 'updated_at'))
      new_hour.update_attributes(hours_spent_params)
      new_hour.old_values = @hour.attributes
      new_hour.of_kind = :billable
      new_hour
      #binding.pry
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
                                          :change_reason,
                                          :toll_expenses_own_car,
                                          :supplies_from_warehouse,
                                          :piecework_hours,
                                          :hour, :description, :date)
    end

    def set_task
      @task = Task.find(params[:task_id])
    end

    def set_by_hours_spent_id
      @hour = HoursSpent.find(params[:hours_spent_id])
    end

  end
end
