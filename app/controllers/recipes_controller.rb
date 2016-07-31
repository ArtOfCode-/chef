class RecipesController < ApplicationController
  before_action :authenticate_user!, :except => [:show, :public_list]
  before_action :set_recipe, :only => [:show, :edit, :update, :destroy]
  before_action :verify_authorization, :only => [:edit, :update, :destroy]
  before_action :verify_show_auth, :only => [:show]

  @@markdown_renderer = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(), extensions = {})

  def self.renderer
    @@markdown_renderer
  end

  def show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    # We get the access level ID as a parameter, not the AccessLevel itself, so let's set that up properly to avoid errors.
    params[:recipe][:access_level] = AccessLevel.where(:id => params[:recipe][:access_level]).first

    @recipe = Recipe.new recipe_params
    @recipe.user = current_user
    @recipe.access_level = params[:recipe][:access_level]
    if @recipe.save
      redirect_to url_for(:controller => :recipes, :action => :show, :id => @recipe.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    params[:recipe][:access_level] = AccessLevel.where(:id => params[:recipe][:access_level]).first

    @recipe.access_level = params[:recipe][:access_level]
    if @recipe.update(recipe_params)
      redirect_to url_for(:controller => :recipes, :action => :show, :id => @recipe.id)
    else
      render :edit
    end
  end

  def destroy
    @recipe.destroy!
    redirect_to url_for(:controller => :recipes, :action => :my_list)
  end

  def public_list
    @recipes = Recipe.publics
  end

  def internal_list
    @recipes = Recipe.internals
  end

  def my_list
    @recipes = Recipe.users(current_user)
  end

  private
    def set_recipe
      @recipe = Recipe.find params[:id]
    end

    def verify_authorization
      @recipe.user == current_user || current_user.is_admin
    end

    def verify_show_auth
      if @recipe.access_level.name == 'Public'
        return true
      else
        render :template => 'errors/not_found' unless user_signed_in? && @recipe.has_access(current_user)
      end
    end

    def recipe_params
      params.require(:recipe).permit(:title, :description, :ingredients, :method, :time, :category, :access_level)
    end
end

class MarkdownScrubber < Rails::Html::PermitScrubber
  def initialize
    super
    self.tags = %w( a p b i em strong hr h1 h2 h3 h4 h5 h6 blockquote img strike del code pre br ul ol li )
    self.attributes = %w( href title src height width )
  end

  def skip_node?(node)
    node.text?
  end
end
