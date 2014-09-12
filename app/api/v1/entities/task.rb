module V1
  module Entities
    class Tasks < Grape::Entity
      expose :id, :description, :project_id, :project_url
    end

    def project_url
      'http://db.no'
    end
  end
end
