module V1
  module Entities
    class Users < Grape::Entity
      expose :id, :first_name, :last_name, :email
    end
  end
end
