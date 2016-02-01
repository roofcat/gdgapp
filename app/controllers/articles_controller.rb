class ArticlesController < ApplicationController

	before_action :set_article, except: [:index, :new, :create]

	def index
		@articles = Article.ultimos
	end

	def show
		@article.update_visits_count
	end

	def new
		@article = Article.new
	end

	def edit
	end

	def create
		@article = Article.new(article_params)
		#@article.categories = params[:categories]

		if @article.save
			redirect_to @article
		else
			render :new
		end
	end

	def destroy
		@article.destroy
		redirect_to articles_path
	end

	def update
		if @article.update(article_params)
			redirect_to @article
		else
			render :edit
		end
	end

	private

	def set_article
		@article = Article.find(params[:id])
	end

	def article_params
		params.require(:article).permit(:title, :body, :cover, :categories)
	end
end
