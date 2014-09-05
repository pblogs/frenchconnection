class HoursSpent::ChangesController < ApplicationController
  def new
    @hour_spent = HoursSpent.find(params[:hours_spent_id])
    @change     = @hour_spent.changes.new
  end
end
