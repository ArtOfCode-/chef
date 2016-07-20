class HomeController < ApplicationController
  def index
    @featured = Rails.cache.fetch('featured_recipes', :expires_in => 1.day) do
      Recipe.publics.joins(:favorites).where(:created_at => 1.day.ago..Time.now).group('recipes.id').order('COUNT(recipes.id) DESC').limit(3)
    end
    @favorited = Rails.cache.fetch('favorited_recipes', :expires_in => 30.minutes) do
      Recipe.publics.joins(:favorites).group('recipes.id').order('COUNT(recipes.id) DESC').limit(3)
    end
  end
end
