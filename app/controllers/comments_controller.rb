class CommentsController < ApplicationController

	before_action :set_comment, only: [:show, :edit, :update, :destroy]
	before_action :set_article
	before_action :authenticate_user!

	def index
		@comments = Comment.all
	end

	def show
	end

	def new
		@comment = Comment.new
	end

	def edit
	end

	def create
		@comment = current_user.comments.new(comment_params)
		@comment.article = @article

		respond_to do |format|
			if @comment.save
				format.html { redirect_to @comment.article, notice: "Comentario fue creado." }
				format.json { render :show, status: :created, location: @comment.article }
			else
				format.html { render :new }
				format.json { render json: @comment.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @comment.update(comment_params)
				format.html { redirect_to @comment.article, notice: "Comentario actualizado." }
				format.json { render :show, status: :ok, location: @comment }
			else
				format.html { render :edit }
				format.json { render json: @comment.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@comment.destroy
		respond_to do |format|
			format.html { redirect_to @article, notice: "Comentario eliminado." }
			format.html { head :no_content }
		end
	end

	private

		def set_comment
			@article = Comment.find(:params[:id])
		end

		def set_article
			@article = Article.find(params[:article_id])
		end

		def comment_params
			params.require(:comment).permit(:body)
		end

end
