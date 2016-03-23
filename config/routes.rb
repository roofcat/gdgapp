Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
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

	get '/dashboard', to: 'dashboard#index'

	root 'welcome#index'

end
