module V1
  module Entities
    class Customers < Grape::Entity
      expose :id, :name, :address, :contact_person, :phone, :area, :email
    end
  end
end
