class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, :only => [:destroy]
  before_action :verify_access, :only => [:destroy]

  def create
    @comment = Comment.new comment_params
    @comment.user = current_user
    @comment.recipe = Recipe.find params[:id]
    if @comment.save
      render :json => { :status => 'success', :insert => CommentsController.render(locals: { :comment => @comment }, partial: 'comment').html_safe }, :status => 201
    else
      render :json => { :status => 'failed', :message => 'Object failed to save.' }, :status => 500
    end
  end

  def destroy
    if @comment.destroy
      render :json => { :status => 'success' }
    else
      render :json => { :status => 'failed', :message => 'Failed to destroy object.' }, :status => 500
    end
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
