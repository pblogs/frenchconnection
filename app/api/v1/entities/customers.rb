module V1
  module Entities
    class Customers < Grape::Entity
      expose :id, :name, :address
    end
  end
end
