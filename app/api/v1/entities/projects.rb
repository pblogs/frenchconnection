module V1
  module Entities
    class Projects < Grape::Entity
      expose :id, :name, :description
    end
  end
end
