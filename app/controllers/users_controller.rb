class UsersController < ApplicationController
  def index
    @users = User.all
    case params[:sort]
    when 'newest'
      @users.order(:created_by => :desc)
    when 'recipes'
      @users.joins(:recipes).group('users.id').order('COUNT(users.id) DESC')
    when 'alpha'
      @users.order(:username)
    end
    @users = @users.paginate(:page => params[:page], :per_page => 50)
  end

  def show

  end

  def recipes

  end
end
