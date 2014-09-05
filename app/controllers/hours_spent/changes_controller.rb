class HoursSpent::ChangesController < ApplicationController
  def new
    @hour_spent = HoursSpent.find(params[:hours_spent_id])
    @change     = Change.new(@hours_spent.attributes)
  end
end
