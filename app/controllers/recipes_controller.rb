class RecipesController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :public_list]
  before_action :set_recipe, :only => [:show, :new, :create, :edit, :update, :destroy]
  before_action :verify_authorization, :only => [:edit, :update, :destroy
  before_action :verify_show_auth, :only => [:show]

  def show

  end

  def new

  end

  def create

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
end
