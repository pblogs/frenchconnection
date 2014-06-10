class StaticPagesController < ApplicationController

  def frontpage_manager
  end

  def new_assignment
    @customers = Customer.all
  end

  def frontpage_artisan
    @new_tasks = @current_user.tasks.where(accepted: nil).to_a
  end


end
