module V1
  class HoursSpents < Base

    resource :hours_spents do
      
      desc "Update HoursSpents with given id"
      params do
        requires :hours_spent_id, type: Integer, desc: "HoursSpent id."
      end
      route_param :hours_spent_id do
        options do
          header 'Access-Control-Allow-Headers', 'Content-Type'
          header 'Access-Control-Allow-Methods', 'PUT'
          header 'Access-Control-Allow-Origin', '*'
        end
        
        put do
          hours_spent = HoursSpent.find(params[:hours_spent_id])
          
          request_params = ActionController::Parameters.new(params)
          permitted_params = request_params.permit(:hour, :overtime_50, 
            :overtime_100, :description, :runs_in_company_car, 
            :km_driven_own_car, :toll_expenses_own_car, 
            :supplies_from_warehouse)
          
          if hours_spent.update(permitted_params)
            present :hours_spent, hours_spent, with: V1::Entities::HoursSpents
            header 'Access-Control-Allow-Origin', '*'
          else
            error! hours_spent.errors, 400
            header 'Access-Control-Allow-Origin', '*'
          end
        end
        
      end

    end
  end
end
