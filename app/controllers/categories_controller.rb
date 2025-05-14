class CategoriesController < ApplicationController
  def index
    @categories = Category.all.order(:id).page(params[:page]).per(10)
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_params)
    @category.save
  end

  private

  def category_params
    params.require(:category).permit(:title, :body)
  end
end
