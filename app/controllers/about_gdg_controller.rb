class AboutGdgController < ApplicationController

	before_action :set_about_gdg, except: [:index, :new, :create]

	def index
		@about_gdg = AboutGdg.all
	end
	
	def show
	end

	def new
		@about_gdg = AboutGdg.new
	end

	def create
		@about_gdg = AboutGdg.new(about_gdg_params)

		if @about_gdg.save
			redirect_to @about_gdg
		else
			render :index
		end
	end

	def destroy
		@about_gdg.destroy
		redirect_to about_gdg_path
	end

	def update
	end

	private

		def set_about_gdg
			@about_gdg = AboutGdg.find(params[:id])
		end

		def contact_params
			params.require(:about_gdg).permit(:title, :body)
		end

end
