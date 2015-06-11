Orwapp::Application.routes.draw do

  ActiveAdmin.routes(self)
  resources :submissions
  resources :dynamic_forms do
    get :submissions
  end


  namespace :inventories do
    post :search
  end

  resources :locations
  resources :skills
  resources :inventories
  resources :departments
  resources :attachments

  devise_for :users

  mount API => '/'

  get '/daily_report/:project_id/:profession_id/:overtime' => 'excel#daily_report',
    as: :daily_report

  get 'monthly_report/:project_id/:year/:month/:overtime' => 'excel#monthly_report',
      as: :monthly_report

  resources :projects do
    post :approve_hours
    get :billable_hours
    get :personal_hours
    get :hours
    get :documentation
    get :deviation
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

  get '/users/search/'=> 'users#search', as: :user_search

  resources :users do
    get '/tasks/started'     => 'users/tasks#started'
    get '/tasks/not_started' => 'users/tasks#not_started'
    get '/projects/:project_id/hours'=> 'users#hours', as: :hours
    post '/projects/:project_id/hours'=> 'users#hours', as: :approve_hours
    get :timesheets
    get :certificates
    patch '/create_certificate/' => 'users#create_certificate', as: :create_certificate
    resources :certificates, :controller => 'users/certificates', only: [:show, :destroy]
    resources :tasks, :controller => 'users/tasks' do
      post :accept_task
      post :finished
      get :send_message
    end
    resources :tasks, :controller => 'users/user_tasks' do
      post :confirm_user_task
    end
    collection do
      post :add_user
    end
  end
  resources :certificates

  resources :hours_spents do
  end
  resources :tasks do
    post :save_and_order_resources,   as: :save_and_order_resources
    resources :hours_spents, :controller => 'tasks/hours_spents' do
      get  :approve
    end
    member do
      post :complete
    end
  end


  get '/blog'             => 'blog#index',            as: :blog
  get '/news_archive'     => 'blog#news_archive',     as: :news_archive
  get '/projects_archive' => 'blog#projects_archive', as: :projects_archive
  get '/hms'              => 'blog#hms',              as: :hms
  get '/instructions'     => 'blog#instructions',     as: :instructions
  get '/video'            => 'blog#video',            as: :video
  get '/video/:id'        => 'blog#video',            as: :current_video
  get '/administration'   => 'blog#administration',   as: :administration
  get '/hr'               => 'blog#hr',               as: :hr


  get '/manager' => 'blog#frontpage_manager', as: :frontpage_manager
  get '/worker'  => 'blog#frontpage_user', as: :frontpage_user
  get '/new_assignment' => 'blog#new_assignment', as: :new_assignment
  get '/sallery/:user_id/:project_id/'  => 'excel#sallery', as: :sallery_report
  get '/blog/:content_type/:id' => 'blog#content', as: :blog_content


  get '/html_export/:user_id/:project_id/' => 'excel#html_export', as: :html_export

  get '/templates/:path' => 'templates#template',
    :constraints => { :path => /.+/  }

  get '/hse' => 'hse#redirect', as: 'hse'

  post '/blog_images' => 'blog_images#create', as: :blog_images

  get '*path' => redirect('/')
  root 'blog#index'

end
