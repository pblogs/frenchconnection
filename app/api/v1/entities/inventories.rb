module V1
  module Entities
    class Inventories < Grape::Entity
      expose :id, :name, :description
    end
  end
end
