class UsersController < ApplicationController
  before_action :set_user, :only => [:show, :recipes]

  def index
    @users = User.all
    case params[:sort]
    when 'newest'
      @users = @users.order(:created_at => :desc)
    when 'recipes'
      @users = @users.joins(:recipes).group('users.id').order('COUNT(users.id) DESC')
    when 'alpha'
      @users = @users.order(:username => :asc)
    end
    @users = @users.paginate(:page => params[:page], :per_page => 50)
  end

  def show
  end

  def recipes
    case params[:type]
    when 'public'
      @recipes = @user.public_recipes
    when 'internal'
      unless user_signed_in?
        render 'errors/not_found' and return
      end
      @recipes = @user.internal_recipes
    when 'private'
      unless user_signed_in? && (current_user == @user || current_user.is_admin)
        render 'errors/not_found' and return
      end
      @recipes = @user.private_recipes
    else
      render 'errors/not_found' and return
    end
    @recipes = @recipes.paginate(:page => params[:page], :per_page => 25)
  end

  private
    def set_user
      @user = User.find params[:id]
    end
end
