class StaticPagesController < ApplicationController

  def frontpage_manager
  end

  def new_assignment
    @customers = Customer.all
  end

  def frontpage_artisan
    @task = Task.last
  end


end
