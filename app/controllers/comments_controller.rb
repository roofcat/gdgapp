class CommentsController < ApplicationController

	before_action :set_commentable, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!

	def edit
	end

	def create
		@comment = @commentable.comments.new(comment_params)
		@comment.user = current_user

		respond_to do |format|
			if @comment.save
				format.html { redirect_to @commentable, notice: "Comentario fue creado." }
				format.json { render :show, status: :created, location: @commentable }
			else
				format.html { render :new }
				format.json { render json: @comment.errors, status: :unprocessable_entity }
			end
		end
	end

	def update
		respond_to do |format|
			if @comment.update(comment_params)
				format.html { redirect_to @commentable, notice: "Comentario actualizado." }
				format.json { render :show, status: :ok, location: @commentable }
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

		def comment_params
			params.require(:comment).permit(:body)
		end

end
