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
          hours_spent.hour                    = params[:hour] || hours_spent.hour
          hours_spent.overtime_50             = params[:overtime_50] || hours_spent.overtime_50 
          hours_spent.overtime_100            = params[:overtime_100] || hours_spent.overtime_100
          hours_spent.description             = params[:description] || hours_spent.description 
          hours_spent.runs_in_company_car     = params[:runs_in_company_car] || hours_spent.runs_in_company_car
          hours_spent.km_driven_own_car       = params[:km_driven_own_car] || hours_spent.km_driven_own_car
          hours_spent.toll_expenses_own_car   = params[:toll_expenses_own_car] || hours_spent.toll_expenses_own_car
          hours_spent.supplies_from_warehouse = params[:supplies_from_warehouse] || hours_spent.supplies_from_warehouse
          
          hours_spent.save!
          
          present 'OK'
          header 'Access-Control-Allow-Origin', '*'
        end
      end

    end
  end
end
