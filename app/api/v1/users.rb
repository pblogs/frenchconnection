module V1
  class Users < Base

    resource :users do


      params do
        requires :id, type: Integer, desc: "Status id."
      end
      route_param :id do
        get do
          User.find(params[:id])
        end
      end

      # Returner array med tasks. ID, title, 
      # description., prosject_id
      # prosjektnanv og kundenavn, url til projekt
      
      desc "Return user with ID."
      params do
        requires :id, type: Integer, desc: "User id."
      end
      route_param :id do
        get 'unconfirmed_tasks' do
          u = User.find(params[:id])
          present :tasks, u.tasks, 
            with: V1::Entities::Tasks
        end
      end

      desc "confirmed_tasks"
      params do
        requires :id, type: Integer, desc: "User id."
      end
      route_param :id do
        get 'confirmed_tasks' do
          u = User.find(params[:id])
          #tasks = u.tasks # TODO only return confirmed tasks
        end
      end


      params { requires :id }
      route_param :id do
        get do
          user = User.find(params[:id])
          present :user, user, with: V1::Entities::Users
        end
      end

      #desc 'Get the newest 25 users regardless of location'
      #get 'recent' do
      #  cache key: "api-v1-users-recent", expires_in: 10.minutes do
      #    users = Ad.latest.limit(25)
      #    present :users, users, with: V1::Entities::Users
      #  end
      #end

      #desc 'Retreive all users or search by query'
      #params do
      #  use :requires_coordinates, :optional_geo_range, :optional_pagination
      #end
      #get do
      #  query         = params[:query].present? ? params[:query] : nil
      #  page_nr       = Pagination.page_nr(params[:page])
      #  search_params = Search.build_query(query: query,
      #                    lat: params[:lat], lon: params[:lon],
      #                    from: params[:from], to: params[:to])

      #  users          = Ad.search(search_params).page(page_nr).records
      #  newest_first = users.sort_by{ |rec| rec[:created_at] }.reverse
      #  present :users, newest_first, with: V1::Entities::Users
      #end



      #desc 'Update existing user, applies only to the signed in user\'s users'
      #params do
      #  use :requires_user_id, :optional_user_attribs, :optional_coordinates
      #end
      #route_param :id do
      #  put do
      #    user = current_user.users.find(params[:id])
      #    if user.update(permitted_params)
      #      present :user, user, with: V1::Entities::Users
      #    else
      #      error! user.errors, 400
      #    end
      #  end
      #end

      #desc 'Change state of user, applies only to the signed in user\'s users'
      #params { use :requires_user_id, :requires_transition }
      #route_param :id do
      #  put 'event/:transition' do
      #    user = current_user.users.find(params[:id])
      #    if user.fire_state_event(params[:transition])
      #      present :user, user, with: V1::Entities::Users
      #    else
      #      error! user.errors, 400
      #    end
      #  end
      #end

      #desc 'Create new user'
      #params do
      #  use :requires_coordinates, :requires_user_attribs, :requires_prospect_image
      #end
      #post do
      #  attachment =  handle_image
      #  lat_lon = { lat: params[:lat], lon: params[:lon] }
      #  user = Ad.new(permitted_params.merge(
      #    user:        current_user,
      #    coordinates: lat_lon,
      #    prospect_image: attachment)
      #  )

      #  if user.save
      #    user.prospect_image.save
      #    present :user, user, with: V1::Entities::Users
      #  else
      #    error! user.errors, 400
      #  end
      #end

    end
  end
end
