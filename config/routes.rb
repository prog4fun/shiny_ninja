ShinyNinja::Application.routes.draw do
  

  # Reports
  # get "/reports/import", :controller => "reports", :action => "import"
  
  # projects_Users
  get "/projects_users/confirm_project_evaluator", :controller => "projects_users", :action => "confirm_project_evaluator"
  
  # Index
  authenticated do
    get "/", :controller => "indices", :action => "start"
  end
  
  get "/", :controller => "indices", :action => "home"
  get "/index/start", :controller => "indices", :action => "start"
  get "/index/home", :controller => "indices", :action => "home"
  get "/index/impressum", :controller => "indices", :action => "impressum"
  get "/index/impressum", :controller => "devise/indices", :action => "impressum"
  get "/index/administrator", :controller => "indices", :action => "administrator"
  get "/index/timetracker", :controller => "indices", :action => "timetracker"
  get "/index/projectevaluator", :controller => "indices", :action => "projectevaluator"

  
  # Resources
  resources :bills
  
  resources :services

  resources :reports
  
  resources :projects_users
  
  resources :projects

  devise_for :users, :controllers => { :registrations => :registrations, :passwords => :passwords}

  resources :customers

  resources :users

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   get 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   get 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'indices#start'


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # get ':controller(/:action(/:id))(.:format)'
end
