LantanOfficial::Application.routes.draw do
  get "cards/index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
  resources :product_information
  resources :products
  resources :reservations
  resources :sales
  resources :stores
  resources :teams
  resources :homepage do
    collection do
    get :login
    get :logoff
    get :regist
    post :regist_create
    post :login_create
    get :about_lantan
    get :company_introduce
    get :company_culture
    get :characteristic_service
    get :managment_idea
    get :store_introduce
    get :team_introduce
    get :sales_promotion
    get :sv_cards
    get :news_centre
    get :customer_investigate
    get :contact_us
    get :show_sale
    get :show_new
    get :contact_us
    post :provincechange
    post :citychange
    end
  end
  resources :news
  resources :cards
  resources :official_sale do
    collection do
      post :province_change
      post :city_change
      post :province_change_reservations
      post :city_change_reservations
    end
  end

  resources :stores do
    resources :products
    resources :reservations 
    resources :teams
    resources :sales
  end

 
  
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
     root :to => 'homepage#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
