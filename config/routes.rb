AllieroForms::Application.routes.draw do

  root "application#index"
  #root 'static_pages#blog'

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :tasks
      resources :customers
    end
  end


  devise_for :users
  get "excel/export/:project_id" => 'excel#export', as: :export_excel
  resources :projects do
    resources :tasks, :controller => 'projects/tasks'
  end

  get '/timesheets' => 'excel#timesheets', as: :timesheets
  get '/timesheet/:project_id/:user_id' => 'excel#timesheet', as: :timesheet

  namespace :excel do
  end

  namespace :tasks do
    get :active
    get :report
  end

  resources :customers do
    resources :projects, :controller => 'customers/projects'
    get :excel_report
  end

  resources :users do 
    get '/tasks/started'     => 'users/tasks#started'
    get '/tasks/not_started' => 'users/tasks#not_started'
    resources :tasks, :controller => 'users/tasks' do
      post :accept_task
      post :finished
      get :send_message
    end
  end

  resources :hours_spents
  resources :tasks do
    resources :hours_spents, :controller => 'tasks/hours_spent'
  end



  resources :task_types

  # The priority is based upon order of 
  # creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  
  get '/blog' => 'static_pages#blog', as: :blog

  # You can have the root of your site routed with "root"
  get '/manager' => 'static_pages#frontpage_manager', as: :frontpage_manager
  get '/worker'  => 'static_pages#frontpage_user', as: :frontpage_user
  get '/new_assignment'    => 'static_pages#new_assignment', as: :new_assignment
  get '/sallery/:user_id/:project_id/'    => 'excel#sallery', as: :sallery_report
  get '/dagsrapport/:project_id/'   => 'excel#dagsrapport', as: :dagsrapport
  get '/html_export/:user_id/:project_id/'    => 'excel#html_export', as: :html_export
  

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
