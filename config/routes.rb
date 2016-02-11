Rails.application.routes.draw do
  
  	resources :about_gdgs

  	resources :categories
  	
  	resources :contacts

	resources :articles do
		resources :comments, only: [:create, :destroy, :update, :show]
	end

	resources :events do
		
	end
  
	devise_for :users

	root 'welcome#index'

end
