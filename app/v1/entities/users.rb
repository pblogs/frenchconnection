module V1
  module Entities
    class Users < Grape::Entity
      expose :id, :created_at, :updated_at, :email
      expose :first_name, :last_name, :profile_url, :image_url
      expose :tasks, using: V1::Entities::Tasks

      def tasks
        object.tasks
      end

    end
  end
end
