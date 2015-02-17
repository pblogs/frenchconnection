module V1
  module Entities
    class Attachments < Grape::Entity
      expose :id, :document, :description
    end
  end
end
