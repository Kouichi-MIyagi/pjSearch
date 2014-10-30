PjSearch::Application.routes.draw do
  
  get "db_counter/index"

  get "db_counter/show"

#  resources :uploaded_user_states

  resources :statuses

  resources :user_states do
    collection do
      post 'upload'
    end
  end
  
  match 'request_questionnaires/sendRequestMail/:id' => 'request_questionnaires#sendRequestMail'
  match 'responses/index/:request_id' => 'responses#index'

  resources :topics

  resources :request_questionnaires

  resources :questionitems

  resources :questionnaires

  devise_for :users, :controllers => {
  :sessions      => 'users/sessions',
  :registrations => 'users/registrations',
  :passwords     => 'users/passwords'
  }
  
  devise_scope :user do
    match 'user/index' => 'users/registrations#index'
    match 'users' => 'users/registrations#index'
    match 'user/show/:id' => 'users/registrations#show', :as => :admin_show_user
    match 'users/:id' => 'users/registrations#destroy', :as => :admin_destroy_user
    match 'user/upload' => 'users/registrations#upload'
    match 'user/become/:id' => 'users/registrations#become', :as => :sign_in_as_another_user
  end
 
  root :to => 'menu#index'
  
  resources :customers

  resources :response_items
  resources :responses

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
   match ':controller(/:action(/:id))(.:format)'
end
