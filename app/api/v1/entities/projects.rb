module V1
  module Entities
    class Projects < Grape::Entity
      expose :id, :name, :customer_id, :description, :execution_address,
             :start_date, :due_date, :customer_reference, :comment
    end
  end
end
