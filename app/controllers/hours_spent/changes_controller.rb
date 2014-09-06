class HoursSpent::ChangesController < ApplicationController

  def new
    @hours_spent = HoursSpent.find(params[:hours_spent_id])
    @change     = Change.create_from_hours_spent(hours_spent: @hours_spent)
  end

  def create
    @change = Change.new(change_params)
    @hours_spent = HoursSpent.find(params[:hours_spent_id])
    @change.hours_spent = @hours_spent
    if @change.save
      redirect_to hours_registered_path(@change.hours_spent.project)
    else
      render :new
    end
  end

  def edit
    @hours_spent = HoursSpent.find(params[:hours_spent_id])
    @change = Change.find(params[:id])
    render :new
  end

  def update
    @change = Change.find(params[:id])
    @change.update_attributes(change_params)
    if @change.save!
      puts "\n\n\n change.hours_spent.task is #{@change.hours_spent.task.inspect}\n\n\n"
      puts "Will redirect to this id #{@change.hours_spent.task.project.id}"
      redirect_to hours_registered_path(@change.hours_spent.task.project.id)
    else
      render :edit
    end
  end


  private 


  def change_params
    params.require(:change).permit(
      :description, 
      :cust, :customer_id, :id, :task_id, :date, :user_id, :project_id, :hour,
      :text, :runs_in_company_car, :km_driven_own_car, :toll_expenses_own_car, 
      :supplies_from_warehouse, :piecework_hours, :overtime_50, :reason,
      :overtime_100
    )
  end
end
