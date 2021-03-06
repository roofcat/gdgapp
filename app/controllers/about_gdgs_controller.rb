class AboutGdgsController < ApplicationController

	before_action :set_about_gdg, except: [:index, :new, :create]
	before_action :authenticate_user!, except: [:show, :index]
	before_action :authenticate_admin!, only: [:new, :create, :update, :destroy]

	def index
		@about_gdg = AboutGdg.first
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
		redirect_to about_gdg_index_path
	end

	def update
		if @about_gdg.update(about_gdg_params)
			redirect_to @about_gdg
		else
			render :edit
		end
	end

	private

		def set_about_gdg
			@about_gdg = AboutGdg.find(params[:id])
		end

		def about_gdg_params
			params.require(:about_gdg).permit(:title, :body, :markup_body)
		end

end
