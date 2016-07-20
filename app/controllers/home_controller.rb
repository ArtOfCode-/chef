class HomeController < ApplicationController
  def index
    @featured = Rails.cache.fetch('featured_recipes', :expires_in => 1.day) do
      Recipe.publics.joins(:favorites).where(:updated_at => 1.day.ago..Time.now).group('recipes.id').order('COUNT(recipes.id) DESC').limit(3)
    end
    @favorited = Rails.cache.fetch('favorited_recipes', :expires_in => 30.minutes) do
      Recipe.publics.joins(:favorites).group('recipes.id').order('COUNT(recipes.id) DESC').limit(3)
    end
    @commented = Rails.cache.fetch('commented_recipes', :expires_in => 30.minutes) do
      Recipe.publics.joins(:comments).group('recipes.id').order('COUNT(recipes.id) DESC').limit(3)
    end
  end
end
