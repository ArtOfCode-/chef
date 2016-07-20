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
  end

  private
    def set_user
      @user = User.find params[:id]
    end
end
