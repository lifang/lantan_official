LantanOfficial::Application.routes.draw do
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
  match '/logout'=> 'homepage#logout'
  match '/login'=> 'homepage#login'
  match '/regist'=> 'homepage#regist'
  match '/introduce'=> 'homepage#company_introduce'
  match '/characteristic'=> 'homepage#characteristic_service'
  match '/managment'=> 'homepage#managment_idea'
  match '/culture'=> 'homepage#company_culture'
  match '/team'=> 'homepage#team_introduce'
  match '/store'=> 'homepage#store_introduce'
  match '/contact_us'=> 'homepage#contact_us'
  
  #resources :user_infos
  match "user_infos/con_records" => "user_infos#con_records"
  match "user_infos/svcard_records" => "user_infos#svcard_records"
  match "user_infos/pcard_records" => "user_infos#pcard_records"
  match "user_infos/con_records/search" => "user_infos#search"
  resources :product_information
  resources :surveys
  resources :homepage do
    collection do
      get :login, :logout, :regist
      get :sales_promotion, :sv_cards, :news_centre, :show_sale, :show_new, :contact_us
      post :regist_create, :login_create, :provincechange, :citychange
    end
  end
  resources :news
  resources :cards do
    collection do
      get :alipay_exercise
      post :alipay_compete,:check_card
    end
  end
  resources :official_sale do
    collection do
      get :province_change, :city_change
      post :province_change_reservations, :city_change_reservations
    end
  end
  resources :products
  resources :stores do
    collection do
      post :send_file
    end
    resources :products
    resources :reservations 
    resources :sales
  end

  resources :apis do
    collection do
      post :get_user_svcard
      post :use_svcard
    end
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
