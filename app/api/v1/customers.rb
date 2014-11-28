module V1
  class Customers < Base

    include Grape::Rails::Cache

    resource :customers do
      
      desc "all customers"
      get do
        last_updated = Customer.last_updated_at
        cache(
            key: "api:v1:customers:#{last_updated.to_i}",
            etag: last_updated,
            expires_in: 2.hours) do

          customers = Customer.all
          present(:customers, customers, with: V1::Entities::Customers).as_json

        end
        header 'Access-Control-Allow-Origin', '*'
      end

      desc "all projects for a customer"
      params do
        requires :id, type: Integer, desc: "Customer id."
      end
      route_param :id do
        get 'projects' do
          customer = Customer.find(params[:id])
          #raise "projects: #{customer.projects.inspect}"
          present :projects, customer.projects.all, with: V1::Entities::Projects
        end
      end

      desc "Get a customer"
      params do
        requires :id, type: Integer, desc: "Customer id."
      end
      route_param :id do
        get do
          customer = Customer.find(params[:id])
          present :customers, customer, with: V1::Entities::Customers
        end
      end
    end
  end
end
