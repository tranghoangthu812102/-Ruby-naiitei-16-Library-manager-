class CategoriesController < ApplicationController
  before_action :load_category, except: %i(index new create)
  before_action :require_admin, except: %i(index show destroy)

  def index
    search_result = Category.search(params[:name])
    @categories = search_result.page(params[:page]).per(Settings.validation.num)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".create_success"
      redirect_to @category
    else
      flash[:danger] = t ".create_fail"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @category.update category_params
      flash[:success] = t ".edit_success"
      redirect_to @category
    else
      flash[:danger] = t ".edit_fail"
      render :edit
    end
  end

  def destroy
    flash[:success] = t ".category_delete" if @category&.destroy
    redirect_to @category
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def require_admin
    return unless logged_in? && !current_user.admin?

    flash[:alert] = t "only_admin"
    redirect_to categories_path
  end

  def load_category
    @category = Category.find params[:id]
  end
end
