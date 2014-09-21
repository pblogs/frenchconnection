module V1
  module Entities

    class HoursSpents < Grape::Entity
      expose  :task_id, :date, :description, 
              :hour, :overtime_50, :overtime_100, 
              :runs_in_company_car, :km_driven_own_car, 
              :toll_expenses_own_car, :supplies_from_warehouse, :id
      
    end
  end
end