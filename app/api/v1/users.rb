module V1
  class Users < Base
    
    resource :users do

      desc "All users with worker role"
      get 'workers' do
        workers = User.with_role(:worker)
        present :users, workers
        header 'Access-Control-Allow-Origin', '*'
      end

      desc "One user"
      params do
        requires :user_id, type: Integer, desc: "User id."
      end
      route_param :user_id do
        get do
          user = User.find(params[:user_id])
          present :user, user
          header 'Access-Control-Allow-Origin', '*'
        end
      end

      desc "Timesheets for user"
      params do
        requires :user_id, type: Integer, desc: "User id."
      end
      route_param :user_id do
        get 'timesheets' do
          user    = User.find(params[:user_id])
          months  = user.monthly_reports.collect(&:month_nr).sort.uniq
          reports = user.monthly_reports

          timesheets = {}
          months.each do |m|
            timesheets[m] = []
            reports.where(month_nr: m).each do |r|
              timesheets[m] << { title: r.title, url: r.document.url }
            end
          end

          present timesheets
          header 'Access-Control-Allow-Origin', '*'
        end
      end

      
    end
  end
end
