class SearchController < ApplicationController
  def results
    search_term = params[:q] || ""
    ordering = params[:order] || "alpha"
    @results = Recipe.where('title LIKE ?', "%#{search_term}%")
               .or(Recipe.where('description LIKE ?', "%#{search_term}%"))
               .or(Recipe.where('ingredients LIKE ?', "%#{search_term}%"))
               .or(Recipe.where('method LIKE ?', "%#{search_term}%"))
    case ordering
    when "alpha"
      @results = @results.order(:title => :asc)
    when "favorites"
      @results = @results.joins(:favorites).group('recipes.id').order('COUNT(recipes.id) DESC')
    when "newest"
      @results = @results.order(:created_at => :desc)
    when 'time'
      @results = @results.order(:time => :asc)
    end
    @results = @results.paginate(:page => params[:page], :per_page => 25)
  end
end
