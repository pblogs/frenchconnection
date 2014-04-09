AllieroForms::Application.routes.draw do



  resources :customers do
    resources :tasks
  end

  resources :artisans do 
    get '/tasks/started'     => 'artisans/tasks#started'
    get '/tasks/not_started' => 'artisans/tasks#not_started'
    resources :tasks, :controller => 'artisans/tasks'


  end

  resources :hours_spents
  resources :tasks do
    resources :hours_spents, :controller => 'tasks/hours_spent'
  end


  resources :task_types

  # The priority is based upon order of 
  # creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#frontpage_manager'
  get '/frontpage_manager' => 'static_pages#frontpage_manager', as: :frontpage_manager
  get '/frontpage_artisan' => 'static_pages#frontpage_artisan', as: :frontpage_artisan
  get '/new_assignment'    => 'static_pages#new_assignment', as: :new_assignment
  

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
