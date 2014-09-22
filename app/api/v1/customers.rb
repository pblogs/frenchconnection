module V1
  class Customers < Base

    resource :customers do
      
      desc "all customers"
      get do
        customers = Customer.all
        present :customers, customers, with: V1::Entities::Customers
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
