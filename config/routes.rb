Rails.application.routes.draw do
  
  get 'about_gdg/controller'

  	resources :categories
  	
  	resources :contacts

	resources :articles do
		resources :comments, only: [:create, :destroy, :update, :show]
	end
  
	devise_for :users

	root 'welcome#index'

end
