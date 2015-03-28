Disponibilites::Application.routes.draw do

  resources :ecoles

  #devise_for :users, :controllers => { sessions: "users/sessions", registrations: "users/registrations" }
  devise_for :user, :controllers => { sessions: "users/sessions", passwords: "users/passwords" }

  resources :roles

  #resources :niveaus

  resources :endroits

  resources :disponibilites do
    collection do
      get "for_calendar"
      get "accept_availability/:id" => 'disponibilites#accept_availability', :as => :accept
      get "deny_availability/:id" => 'disponibilites#deny_availability', :as => :deny
    end
  end

  resources :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  get "home/index"

  root 'home#index'

  #put '/accepter_disponibilite/:id' => 'disponibilites#accepter_disponibilite', :as => :accepter_disponibilite

  #put '/add_to_cart/:id' => 'catalog#add_to_cart', :as => :add_to_cart
  #get "/auth/:provider/callback" => "sessions#create"

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

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
  #       get 'recent', on: :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

end
