Rails.application.routes.draw do

  root 'welcome#index'

	devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

	devise_scope :user do
		get 'sign_out', :to => 'devise/sessions#destroy'
	end

	resources :users, :only => [:index, :show] do
		resources :listings, :except => [:index] do
			collection do
				post 'review'
				get '/', :to => 'listings#user_listings'
			end
		end
	end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

	resources :listings, :only => [:show, :index] do
		collection do 
			get 'search'
		end
		resources :listing_pictures, :only => [:index, :show] do
		end
	end

	resources :listing_pictures, :only => [:create, :show] do
		get 'thumb'
	end

	resources :districts, :only => [] do
		resources :listings, :only => [] do
			collection do 
				get '/', :to => 'listings#district_listings'
			end
		end
	end

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
