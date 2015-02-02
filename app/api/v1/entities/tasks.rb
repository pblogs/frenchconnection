module V1
  module Entities

    class Tasks < Grape::Entity
      expose :id, :description, :project_id,
             :start_date, :due_date, :address
      
    end

  end
end
