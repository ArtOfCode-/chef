class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recipe

  def toggle_favorite
    existing = Favorite.where(:user => current_user, :recipe => @recipe)
    unless existing.exists?
      @favorite = Favorite.new(:user => current_user, :recipe => @recipe)
      if @favorite.save
        render :json => { :status => 'success', :remove_class => 'glyphicon-heart-empty', :add_class => 'glyphicon-heart', :favorite_count => @recipe.favorites.count } and return
      else
        render :json => { :status => 'failed', :message => 'Object failed to save.' }, :status => 500 and return
      end
    else
      if existing.destroy_all
        render :json => { :status => 'success', :remove_class => 'glyphicon-heart', :add_class => 'glyphicon-heart-empty', :favorite_count => @recipe.favorites.count } and return
      else
        render :json => { :status => 'failed', :message => 'Failed to destroy object.' }, :status => 500 and return
      end
    end
  end

  private
    def set_recipe
      @recipe = Recipe.find params[:id]
    end
end
