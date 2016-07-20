class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, :only => [:destroy]
  before_action :verify_access, :only => [:destroy]

  def create
    @comment = Comment.new comment_params
    @comment.user = current_user
    @comment.recipe = Recipe.find params[:recipe_id]
    if @comment.save
      return :json => { :status => 'success', :insert => CommentsController.render(locals: { :comment => @comment }, partial: 'comment').html_safe }, :status => 201
    else
      return :json => { :status => 'failed', :message => 'Object failed to save.' }, :status => 500
    end
  end

  def destroy

  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end

    def set_comment
      @comment = Comment.find params[:id]
    end

    def verify_access
      @comment.user == current_user || current_user.is_admin
    end
end
