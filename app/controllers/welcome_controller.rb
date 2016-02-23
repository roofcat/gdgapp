class WelcomeController < ApplicationController
	
	def index
		@articles = Article.publicados
		@events = Event.publicados
	end

end
