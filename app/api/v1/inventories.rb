module V1
  class Inventories < Base

    include Grape::Rails::Cache

    resource :inventories do
      
      desc "all inventories"
      get do
        header 'Access-Control-Allow-Origin', '*'

        Inventory.all.to_a
        #last_updated = Inventory.last_updated_at
        #cache(
        #    key: "api:v1:inventories:#{last_updated.to_i}",
        #    expires_in: 2.hours) do

        #  inventories = Inventory.all
        #  #present(:inventories, inventories, with: V1::Entities::Inventories)
        #end
      end

      desc "Get a inventory"
      params do
        requires :id, type: Integer, desc: "Inventory id."
      end
      route_param :id do
        get do
          inventory = Inventory.find(params[:id])
          present :inventories, inventory, with: V1::Entities::Inventories
        end
      end
    end
  end
end
