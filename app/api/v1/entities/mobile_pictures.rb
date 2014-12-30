module V1
  module Entities

    class MobilePictures < Grape::Entity
      expose  :task_id, :user_id, :url, :description, :id
      
    end
  end
end
