class IdeasController < ApplicationController
  before_action :authorize_idea_edit, only: %i[edit update destroy]
  def index
    @category = current_user.categories.find(params[:category_id])
    @q = current_user.category_ideas(params[:category_id]).ransack(params[:q])
    @ideas = if @q.present?
      @q.result.page(params[:page]).per(10)
    else
      current_user.category_ideas(params[:category_id]).ransack(params[:q]).per(10)
    end
  end

  def new
    @category = current_user.categories.find(params[:category_id])
    @idea = @category.ideas.build
  end

  def create
    @category = current_user.categories.find(params[:category_id])
    @idea = @category.ideas.build(idea_params)
    @idea.idea_kbn = "0"
    @idea.sort = 0

    if @idea.save
      redirect_to category_ideas_path(@category), success: "アイデアを登録しました"
    else
      flash.now[:error] = "アイデアの登録に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @idea = Idea.find(params[:id])
  end

  def update
    @idea = Idea.find(params[:id])

    if @idea.update(idea_update_params)
      redirect_to category_ideas_path(@idea.category_id), success: "アイデアを修正しました"
    else
      flash.now[:error] = "アイデアの修正に失敗しました"
      render :edit, status: unprocessable_entity
    end
  end

  def destroy
    @idea = Idea.find(params[:id])
    if @idea.destroy
      redirect_to category_ideas_path(@idea.category_id), success: "アイデアを削除しました"
    else
      flash.now[:error] = "アイデアの削除に失敗しました"
      render :index, status: unprocessable_entity
    end
  end

  private

  def idea_params
    params.require(:idea).permit(:title, :body, :rank)
  end

  def idea_update_params
    params.require(:idea).permit(:title, :body, :rank, :status)
  end

  def authorize_idea_edit
    @idea = Idea.find_by(id: params[:id])
    if @idea.nil? || @idea.category.user_id != current_user.id
      flash[:error] = "このアイデアを編集する権限がありません"
      redirect_to categories_path
    end
  end
end
