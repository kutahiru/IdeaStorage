class CategoriesController < ApplicationController
  def index
    @q = current_user.categories.ransack(params[:q])
    @categories = if @q.present?
      @q.result.page(params[:page]).per(10)
    else
      current_user.categories.page(params[:page]).per(10)
    end
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.build(category_create_params)
    if @category.save
      redirect_to categories_path, success: "カテゴリを登録しました"
    else
      flash.now[:error] = "カテゴリの登録に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_update_params)
      redirect_to categories_path, success: "カテゴリを修正しました"
    else
      flash.now[:error] = "カテゴリの修正に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to categories_path, success: "カテゴリを削除しました"
    else
      flash.now[:error] = "カテゴリの削除に失敗しました"
      render :index, status: :unprocessable_entity
    end
  end

  private

  def category_create_params
    params.require(:category).permit(:title, :body)
  end

  def category_update_params
    params.require(:category).permit(:title, :body, :update)
  end
end
