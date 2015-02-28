Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
  root 'welcome#index'
  get 'help' => 'welcome#help', as: 'help'
  
  get 'problems' => 'problems#index', as: 'problems_index'
  get 'problems/:problem_id' => 'problems#single', as: 'problems_single'
  post 'problems/:problem_id' => 'problems#single_submit'
  get 'problems/append/:problem_type' => 'problems#append', as: 'problems_append'
  get 'problems/:problem_id/edit' => 'problems#edit', as: 'problems_edit'
  post 'problems/:problem_id/edit' => 'problems#edit_submit'
  get 'problems/:problem_id/edit/description' => 'problems#edit_description', as: 'problems_edit_description'
  post 'problems/:problem_id/edit/description' => 'problems#edit_description_submit'
  get 'problems/:problem_id/edit/judge' => 'problems#edit_judge', as: 'problems_edit_judge'
  post 'problems/:problem_id/edit/judge' => 'problems#edit_judge_submit'
  
  get 'status' => 'status#index', as: 'status_index'
  get 'status/:status_id' => 'status#single', as: 'status_single'
  get 'status/:status_id/rejudge' => 'status#rejudge', as: 'status_rejudge'
  
  get 'users/login' => 'users#login', as: 'users_login'
  post 'users/login' => 'users#login_submit'
  get 'users/logout' => 'users#logout', as: 'users_logout'
  get 'users/register' => 'users#register', as: 'users_register'
  post 'users/register' => 'users#register_submit'
  get 'users/edit' => 'users#edit', as: 'users_edit'
  post 'users/edit' => 'users#edit_submit'
end
