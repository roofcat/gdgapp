class ArticlesController < ApplicationController

	before_action :set_article, except: [:show, :index]

	def index
		@articles = Article.all
	end

	def show
	end

	def new
		@article.update_visits_count
		@comment = Comment.new
	end

	def edit
	end

	def create
		@article = current_user.articles.new(article_params)
		@article.categories = params[:categories]

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
