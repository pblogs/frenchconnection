AllieroForms::Application.routes.draw do

  resources :locations

  resources :skills

  resources :certificates

  namespace :inventories do
    post :search
  end

  resources :inventories
  resources :changes
  resources :departments
  resources :attachments

  devise_for :users

  mount API => '/'
  get "excel/export/:project_id" => 'excel#export', as: :export_excel

  get '/daily_report/:project_id/:profession_id/:overtime' => 'excel#daily_report', 
    as: :daily_report

  get 'monthly_report/:project_id/:year/:month/:overtime' => 'excel#monthly_report',
      as: :monthly_report

  get '/projects/:id/hours_registered' => 'projects#hours_registered', as: :hours_registered
  resources :projects do
    resources :tasks, :controller => 'projects/tasks' do
      put :end_task
      put :end_task_hard
      get :tools
      get :workers
      get :review
    end

    resources :project_reports, only: :create
    member do
      post :complete
    end
  end
  resources :project_reports, only: :show

  get '/timesheets' => 'excel#timesheets', as: :timesheets
  get '/timesheet/:project_id/:user_id' => 'excel#timesheet', as: :timesheet

  namespace :excel do
  end

  namespace :tasks do
    get :active
    get :report
    get :qualified_workers
    post :select_inventory, as: :select_inventory
    post :select_workers,   as: :select_workers
    get :selected_workers,  as: :selected_workers
    get :selected_inventories
    get :inventories
    delete :remove_selected_worker
    delete :remove_selected_inventory
  end

  get '/customers/search' => 'customers#search', as: :customer_search
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
    resources :tasks, :controller => 'users/user_tasks' do
      post :confirm_user_task
    end
  end

  resources :hours_spents
  resources :hours_spent do
    resources :changes, :controller => 'hours_spent/changes'
  end
  resources :tasks do
    post :save_and_order_resources,   as: :save_and_order_resources
    resources :hours_spents, :controller => 'tasks/hours_spent'
    member do
      post :complete
    end
  end



 

  # The priority is based upon order of 
  # creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  
  get '/blog'  => 'static_pages#blog',  as: :blog
  get '/hms'   => 'static_pages#hms',   as: :hms
  get '/admin' => 'static_pages#admin',   as: :admin
  get '/instructions'   => 'static_pages#instructions',   as: :instructions
  get '/video' => 'static_pages#video', as: :video

  # You can have the root of your site routed with "root"
  root 'static_pages#blog'
  get '/manager' => 'static_pages#frontpage_manager', as: :frontpage_manager
  get '/worker'  => 'static_pages#frontpage_user', as: :frontpage_user
  get '/new_assignment' => 'static_pages#new_assignment', as: :new_assignment
  get '/sallery/:user_id/:project_id/'  => 'excel#sallery', as: :sallery_report


  get '/html_export/:user_id/:project_id/' => 'excel#html_export', as: :html_export

  get '/templates/:path' => 'templates#template',
    :constraints => { :path => /.+/  }  

  get '/hse' => 'hse#redirect', as: 'hse'

end
