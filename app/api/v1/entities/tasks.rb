module V1
  module Entities

    class Tasks < Grape::Entity
      expose :id, :description, :project_id, :project_url

      def project_url
        project_id = object.project.id
        "http://#{ ENV['DOMAIN'] || 'alliero-orwapp.dev' }" +
        "/projects/#{project_id}/tasks/#{object.id}/"
        # customer_project_path(object.project.customer, 
        # object.project)
      end

      def customer_url
        "http://#{ ENV['DOMAIN'] || 'alliero-orwapp.dev' }" +
          "/customers/#{object.project.customer.id}"
        # customer_project_path(object.project.customer, 
        # object.project)
      end
    end


  end
end
