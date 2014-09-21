module V1
  module Entities

    class Tasks < Grape::Entity
      expose :id, :description, :project_id

    end
    
  end
end
