module V1
  module Entities
    class Users < Grape::Entity
      expose :id, :state, :state_events, :url
      #expose :created_at, :updated_at, :sold_at
      #expose :description, :title, :price
      #expose :address, :lat, :lon
      #expose :user,  using: V1::Entities::Users, unless: { include: :user_ads }
      #expose :image, using: V1::Entities::Attachment

      def id
        object.id.to_s
      end

      def image
        object.prospect_image
      end
    end
  end
end
