module V1
  module Entities
    class Projects < Grape::Entity
      expose :id, :name, :customer_id, :description, :execution_address
    end
  end
end
