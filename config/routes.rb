FankuiB::Application.routes.draw do

  resources :forumdisplays

  resources :messages

  resources :solutions

  resources :cases

  resources :searches

  match 'good' => 'cases#good'


  get "session/follow"
  get "session/keep"
  

  get 'home/show'
  get 'home/autocomplete_user_email'
  get 'home/feed'
  
  match 'ajax/new' => 'ajax#new'
  match 'ajax/edit' => 'ajax#edit'
  match 'ajax/answer' => 'ajax#answer'
  match 'notice/false' => 'ajax#notice' 

  match 'mail' => 'home#mail'
  
  match 'sign' => 'ajax#sign'

  resources :reviews

  resources :presents, :except => :show
  
  match ':year/:month/:day/:id' => "presents#show", :as => 'present', :constraints => { :year => /\d{4}/, :month => /\d{2}/, :day => /\d{2}/ }

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_for :users, :controllers => { :invitations => 'user/invitations' }

  resources :invitations

  resources :users do
    member do
      get "followers"
      get "favorites"
      get "messages"
    end
  end
    
  root :to => "home#index"

  resources :home, :path => "t" do
    collection do
      get :index
    end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
