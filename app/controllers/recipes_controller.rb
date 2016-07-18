class RecipesController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :public_list]
  before_action :set_recipe, :only => [:show, :edit, :update, :destroy]
  before_action :verify_authorization, :only => [:edit, :update, :destroy]
  before_action :verify_show_auth, :only => [:show]

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new recipe_params
    @recipe.user = current_user
    if @recipe.save
      redirect_to url_for(:controller => :recipes, :action => :show, :id => @recipe.id)
    else
      render :new
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  def public_list

  end

  def internal_list

  end

  def my_list

  end

  private
    def set_recipe
      @recipe = Recipe.find params[:id]
    end

    def verify_authorization
      @recipe.user == current_user
    end

    def verify_show_auth
      if @recipe.access_level.name == 'Public'
        return true
      else
        not_found unless user_signed_in? && @recipe.has_access(current_user)
      end
    end

    def recipe_params
      params.require(:recipe).permit(:title, :description, :ingredients, :method, :time, :access_level)
    end
end
