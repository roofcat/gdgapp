Rails.application.routes.draw do
  
  	resources :about_gdgs

  	resources :categories
  	
  	resources :contacts

	resources :articles do
		resources :comments, module: :articles, only: [:create, :destroy, :update, :show]
	end

	resources :events do
		resources :comments, module: :events, only: [:create, :destroy, :update, :show]
	end
  
	devise_for :users

	root 'welcome#index'

end
