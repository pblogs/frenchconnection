module V1
  module Entities
    class Users < Grape::Entity
      expose :id, :created_at, :updated_at, :email
      expose :first_name, :last_name, :profile_url, :image_url
      expose :tasks, using: V1::Entities::Tasks

      #expose :profile_image, as: :image_info, using: V1::Entities::Attachment,
      #  if: lambda { |user, options|
      #    user.profile_image.class.name == 'Attachment' }
      #expose :ads, using: V1::Entities::Ads, if: { include: :user_ads }

      def profile_url
        "http://#{ ENV['DOMAIN'] }/profile/#{ object.slug }"
      end


      def tasks
        object.tasks
      end
    end
  end
end
