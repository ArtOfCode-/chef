class CategoriesController < ApplicationController
  before_action :set_category, :only => [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  before_action :verify_admin, :only => [:destroy]

  def index
    @categories = Category.all.order(:name => :asc).paginate(:page => params[:page], :per_page => 30)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to url_for(:controller => :categories, :action => :index)
    else
      render :new
    end
  end

  def show
    @recipes = @category.recipes.paginate(:page => params[:page], :per_page => 25)
  end

  def edit
  end

  def update
    if @category.update category_params
      redirect_to url_for(:controller => :categories, :action => :index)
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = "Successfully destroyed category '#{@category.name}' (##{@category.id})."
      redirect_to url_for(:controller => :categories, :action => :index)
    else
      flash[:alert] = "Failed to destroy category '#{@category.name}'!"
      redirect_to url_for(:controller => :categories, :action => :show, :id => @category.id)
    end
  end

  def search
    @categories = Category.where('name LIKE \'%?%\'', params[:q]).or(Category.where('description LIKE \'%?%\'', params[:q]))
    count = @categories.count
    @categories = @categories.paginate(:page => params[:page], :per_page => 20)
    render :json => { :items => @categories, :has_more => api_has_more(params[:page], 20, count) }
  end

  private
    def category_params
      params.require(:category).permit(:name, :description)
    end

    def set_category
      @category = Category.find params[:id]
    end

    def verify_admin
      unless current_user.is_admin
        render 'errors/not_found' and return
      end
    end
end
