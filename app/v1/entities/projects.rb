module V1
  module Entities
    class Projects < Grape::Entity
      expose :id, :name
      #expose :first_name, :last_name, :profile_url, :image_url
      #expose :tasks, using: V1::Entities::Tasks

    end
  end
end
