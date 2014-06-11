class StaticPagesController < ApplicationController

  def blog
  end

  def frontpage_manager
  end

  def new_assignment
    @customers = Customer.all
  end



end
